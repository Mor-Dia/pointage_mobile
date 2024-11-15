import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import '../../api/actions/getData.dart';
import 'data_bloc_helpers.dart';
import 'package:equatable/equatable.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc<T> extends Bloc <DataFetchEvent, DataFetchState>{
  final T Function(dynamic response) transformerFunction;
  final String? endPoint;
  final String? customDataPath;
  final String? attributeToGet;
  final bool? isGraphQl;
  DataBloc(this.transformerFunction, this.endPoint, {this.isGraphQl, this.attributeToGet, this.customDataPath,})
      : super(DataFetchInitial()) {
    on<FetchDataEvent>((event, emit) async {
      await getDataFromApi(event);
    });
    on<RefreshDataEvent>((event, emit) async {
      await getDataFromApi(event);
    });
  }

  getDataFromApi(event) async {
    try {
      emit(DataLoading());
      Map<String, dynamic>? parameters;
      if(isGraphQl == true){
        parameters = {
          "query": DataBlocHelpers.generateGraphQLQuery(endPoint, attributeToGet, filter: event.filter)
        };
      }
      final response = await getApiData(endPoint, parameters: parameters, isGraphQl: isGraphQl);
      if(response.statusCode == 200){
        Map<String, dynamic> responseJsonDecoded = jsonDecode(response.body);
        dynamic jsonData;
        String? path = customDataPath?? endPoint;
        if(isGraphQl == true){
          jsonData = responseJsonDecoded["data"][path];
        } else {
          jsonData = responseJsonDecoded["data"][path];
        }
        if (kDebugMode) {
          print("JSON DATA $jsonData");
          // print("JSON DATA SERVICES ${jsonData[endPoint]}");
          // print("JSON DATA SERVICES ${jsonData[endPoint]}");
        }
        T data = this.transformerFunction(jsonData);

        emit(DataSuccess(data: data));
      } else {
        emit(DataSuccess(data: null));
      }
    } catch (err, stacktrace) {
      if (kDebugMode) {
        print("DATA BLOC ERROR $err, $stacktrace");
      }
      emit(DataFailure(error: err));
    }
  }

}