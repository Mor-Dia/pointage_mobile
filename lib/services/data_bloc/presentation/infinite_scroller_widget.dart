import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../bloc/data_bloc.dart';

class InfiniteScrollerWidget<T> extends StatefulWidget {
  final Function customWidget;
  final DataBloc<T> customDataBloc;
  final Map<String, dynamic>? currentFilter;
  const InfiniteScrollerWidget({super.key, required this.customWidget, required this.customDataBloc, this.currentFilter});
  
  @override
  State<InfiniteScrollerWidget<T>> createState() => _InfiniteScrollerWidgetState();
}

class _InfiniteScrollerWidgetState<T> extends State<InfiniteScrollerWidget<T>> {
  
  ScrollController practiceListController = ScrollController();
  late DataBloc<T> customDataBloc;
  bool loadingNewData = false;
  Map<String, dynamic> currentFilter = {};

  @override
  void initState() {
    practiceListController.addListener(getAdditionalData);
    customDataBloc = widget.customDataBloc;
    currentFilter = widget.currentFilter ?? {};
    super.initState();
  }


  getAdditionalData() {
    if (kDebugMode) {
      print("SCROLLING OFFSET: ${practiceListController.offset}, POSITION MAXCSROLL ${practiceListController.position.maxScrollExtent}, MAXSCROLL MINUS: ${practiceListController.position.maxScrollExtent-50}");
    }
    if (practiceListController.offset >= practiceListController.position.maxScrollExtent-50 &&
        !practiceListController.position.outOfRange) {
      print("SCROLLING ${customDataBloc.state is DataSuccess<T>}");
      if(customDataBloc.state is DataSuccess<T>){
        int currentPage = 1;
        Map<String, dynamic>? metadata = (customDataBloc.state as DataSuccess<T>).metadata;
        bool canLoadNewData = (customDataBloc.state as DataSuccess<T>).canLoadNewData;
        if(canLoadNewData){
          if(metadata != null && metadata.containsKey("page")){
            currentPage = metadata['page'];
          }
          setState((){
            loadingNewData = true;
          });
          customDataBloc.add(FetchDataEvent(filter: {...currentFilter, ...{"page": currentPage+1} },));
        }
      }
    }
    // customDataBloc.stream.listen(onData)
  }
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: practiceListController,
      scrollDirection: Axis.vertical,
      child: const SizedBox()
      // Column(
      //     children:  [
      //       const SizedBox(
      //         height: spacingConstant,
      //       ),
      //       Wrap(
      //           spacing: 10,
      //           runSpacing: 10,
      //           children: [
      //             ...pratiques
      //                 .map((toElement) => SizedBox(
      //                 width: size.width / 2 - 25,
      //                 child: CardPratique(
      //                   data: toElement,
      //                   handlePress: () => ShowBottomSheet(context),
      //                 )))
      //                 .toList(),
      //             Visibility(
      //                 visible: loadingNewData,
      //                 child: const Center(
      //                   child: CircularProgressIndicator(),
      //                 )
      //             ),
      //             // ElevatedButton(
      //             //   onPressed: (){
      //             //     int currentPage = 1;
      //             //     if(metadata != null && metadata.containsKey("page")){
      //             //       currentPage = metadata['page'];
      //             //     }
      //             //     customDataBloc.add(FetchDataEvent(filter: {...currentFilter, ...{"page": currentPage+1} },));
      //             //   },
      //             //   child: const Text("Charger plus")
      //             // )
      //           ]
      //       ),
      //     ]
      // ),
    );
  }
}

