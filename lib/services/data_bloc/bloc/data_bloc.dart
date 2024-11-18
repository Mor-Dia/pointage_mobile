import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import '../../api/actions/getData.dart';
import 'data_bloc_helpers.dart';
import 'package:equatable/equatable.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc<T> extends Bloc<DataFetchEvent, DataFetchState> {
  /// A BLoC element to retrieve and transform all kind of data from an API.

  /// Le [transformerFunction] Represente la fonction qui permet de transformer les données reçues en objets utilisables dans l'app
  final T Function(dynamic response) transformerFunction;

  /// Il s'agit de l'endpoint des données à récupérer
  final String? endPoint;

  /// Représente le chémin à suivre pour extraire les données de la réponse de la requête.
  /// Ce paramètre, quand il est [null], le path utilisé est celui du endpoint
  final String? customDataPath;

  /// Sert à déterminer les données à récupérer en cas de requête graphQL
  final String? attributeToGet;

  /// Sert à déterminer s'il s'agit d'une requête GraphQL ou pas
  final bool? isGraphQl;

  /// Sert à déterminer s'il s'agit d'une requête avec pagination ou pas
  final bool isPagination;
  DataBloc(
    this.transformerFunction,
    this.endPoint, {
    this.isGraphQl,
    this.isPagination = false,
    this.attributeToGet,
    this.customDataPath,
  }) : super(DataFetchInitial()) {
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
      if (isGraphQl == true) {
        parameters = {
          "query": DataBlocHelpers.generateGraphQLQuery(
              endPoint, attributeToGet,
              filter: event.filter, useMetadata: isPagination)
        };
      }
      final response = await getApiData(endPoint,
          parameters: parameters, isGraphQl: isGraphQl);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseJsonDecoded = jsonDecode(response.body);
        dynamic jsonData;
        dynamic metaData;
        String? path = customDataPath ?? endPoint;
        if (isGraphQl == true) {
          if (isPagination) {
            jsonData = responseJsonDecoded["data"][path]['data'];
            metaData = responseJsonDecoded["data"][path]['metadata'];
          } else {
            jsonData = responseJsonDecoded["data"][path];
          }
        } else {
          jsonData = responseJsonDecoded["data"][path];
        }
        if (kDebugMode) {
          print("JSON DATA $jsonData");
          print("JSON DATA METADATA $metaData");
        }
        T data = this.transformerFunction(jsonData);
        emit(DataSuccess(data: data, metaData: metaData));
      } else {
        emit(DataSuccess(data: null, metaData: null));
      }
    } catch (err, stacktrace) {
      if (kDebugMode) {
        print("DATA BLOC ERROR $err, $stacktrace");
      }
      emit(DataFailure(error: err));
    }
  }
}
