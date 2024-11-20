import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/data_bloc.dart';
import 'custom_error.dart';
import 'no_data_widget.dart';

class BlocBasedWidget<T> extends StatelessWidget {
  final Function customWidget;
  final DataBloc<T> customDataBloc;
  const BlocBasedWidget({super.key, required this.customWidget, required this.customDataBloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: customDataBloc,
      builder: (context, state) {
        if (state is DataSuccess<T>) {
          print("DATA BLOC BASED DATA $state");
          if(state.data != null || (state.data != null && (state.data as List).isNotEmpty)){
            T data = state.data;
            Map<String, dynamic>? metadata = state.metadata;
            return customWidget(data, metadata);
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
