import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pointage_mobile/services/api/actions/delData.dart';
import 'package:pointage_mobile/services/api/actions/postData.dart';
import 'dart:convert';

part 'post_api_event.dart';
part 'post_api_state.dart';

class PostApiBloc extends Bloc<PostApiEvent, PostApiState> {
  PostApiBloc() : super(PostApiInitial()) {
    on<PostApiMakeCall>((event, emit) async {
      await makeCall(event, emit);
    });
  }

  makeCall(event, emit) async {
    emit(const PostApiProcessing());
    dynamic response;
    if (event.isDeletion) {
      response = await delApiData(event.endpoint, event.parameters);
    } else {
      response = await postApiData(event.endpoint, event.parameters);
    }
    if (kDebugMode) {
      print("POST REQUEST RESPONSE , ${response}, ${response.body}, ${response.statusCode}");
    }
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> responseJsonDecoded = jsonDecode(response.body);
        if (responseJsonDecoded["errors"] != null &&
            responseJsonDecoded["errors"] != "") {
          String message = responseJsonDecoded["errors"] == ""
              ? "Une erreur s'est produite"
              : responseJsonDecoded["errors"];
          emit(PostApiFailure(message: message));
        } else if (responseJsonDecoded["errors"] == null ||
            responseJsonDecoded["errors"] == "") {
          String message = "Opération effectuée avec succès";
          emit(PostApiSuccess(message: message, data:responseJsonDecoded));
        } else if (responseJsonDecoded["data"] == 0) {
          if (responseJsonDecoded["errors"] == "" ||
              responseJsonDecoded["errors"] == null) {
            String message = "Opération effectuée avec succès";
            emit(PostApiSuccess(message: message, data:responseJsonDecoded));
          } else if (responseJsonDecoded["errors"] != null &&
              responseJsonDecoded["errors"] != "") {
            String message = responseJsonDecoded["errors"];
            emit(PostApiFailure(message: message));
          }
        } else if (responseJsonDecoded["data"] == 1) {
          String message = "Opération effectuée avec succès";
          emit(PostApiSuccess(message: message, data:responseJsonDecoded));
        }
      } else {
        String message = "Une erreur s'est produite";
        emit(PostApiFailure(message: message));
      }
    } catch (e, stacktrace) {
      if (kDebugMode) {
        emit(const PostApiFailure(message: "Une erreur est survenue"));
        print("ERROR WHILE MAKING POST REQUEST $e");
        print("ERROR WHILE MAKING POST REQUEST STACKTRACE $stacktrace");
      }
    }
  }
}
