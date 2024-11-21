import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/data_bloc.dart';
import 'custom_error.dart';
import 'no_data_widget.dart';

class BlocBasedWidget<T> extends StatefulWidget {
  final Function customWidget;
  final DataBloc<T> customDataBloc;
  final Map<String, dynamic>? filter;
  final bool useInfiniteScroller;
  const BlocBasedWidget({super.key, required this.customWidget, required this.customDataBloc, this.filter, this.useInfiniteScroller = false});

  @override
  State<BlocBasedWidget<T>> createState() => _BlocBasedWidgetState();
}

class _BlocBasedWidgetState<T> extends State<BlocBasedWidget<T>> {

  late Function customWidget;
  late DataBloc<T> customDataBloc;
  late Map<String, dynamic> filter;
  late bool useInfiniteScroller;
  bool loadingNewData = false;

  ScrollController scrollerController = ScrollController();

  @override
  initState(){
    customWidget = widget.customWidget;
    customDataBloc = widget.customDataBloc;
    filter = widget.filter ?? {};
    useInfiniteScroller = widget.useInfiniteScroller;
    customDataBloc.add(FetchDataEvent(filter: filter));
    scrollerController.addListener(getAdditionalData);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant BlocBasedWidget<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(widget.filter != oldWidget.filter){
      customDataBloc.add(FetchDataEvent(filter: widget.filter));
    }
  }


  @override
  void dispose() {
    super.dispose();
  }

  getAdditionalData(){
    if (scrollerController.offset >= scrollerController.position.maxScrollExtent-50 &&
        !scrollerController.position.outOfRange) {
      // Quand on est presque à la fin du scroll
      if(customDataBloc.state is DataSuccess<T>){
        int currentPage = 1;
        Map<String, dynamic>? metadata = (customDataBloc.state as DataSuccess<T>).metadata;
        bool canLoadNewData = (customDataBloc.state as DataSuccess<T>).canLoadNewData;
        if(canLoadNewData && !loadingNewData){
          // Dans le cas où il y a encore des éléments à récupérer et qu'aucune récupération n'est en cours
          if(metadata != null && metadata.containsKey("current_page")){
            currentPage = metadata['current_page'];
          }
          setState((){
            loadingNewData = true;
          });
          customDataBloc.add(FetchDataEvent(loadNewData: false, filter: {...filter, ...{"page": currentPage+1} },));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: customDataBloc,
      listener: (context, state){
        if(state is DataSuccess<T>){
          if(loadingNewData){
            setState(() {
              loadingNewData = false;
            });
          }
        }
      },
      builder: (context, state) {
        if (state is DataSuccess<T>) {
          if(state.data != null || (state.data != null && (state.data as List).isNotEmpty)){
            String tempString = "";
            int len = 0;
            for(dynamic val in (state.data as List)){
              tempString += "${val.id}, ";
              len += 1;
            }
            if(useInfiniteScroller){
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                controller: scrollerController,
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    customWidget(state),
                    Visibility(
                        visible: loadingNewData,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                    ),
                  ],
                ),
              );
            }
            return customWidget(state);
          }
          return const Center(
            child: NoDataWidget(),
          );
        } else if (state is DataFailure) {
          return const Center(
            child: CustomErrorWidget(),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
