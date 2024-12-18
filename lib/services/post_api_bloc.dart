import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:yogivida_mobile/services/api/actions/postData.dart';
import 'dart:convert';

part 'post_api_event.dart';
part 'post_api_state.dart';

class PostApiBloc extends Bloc<PostApiEvent, PostApiState> {
  PostApiBloc() : super(PostApiInitial()) {
    on<PostApiMakeCall>((event, emit) async {
      await makeCall(event,emit);
    });
  }

  makeCall(event,emit) async {
     emit(const PostApiProcessing());
    final response = await postApiData(event.endpoint, event.parameters);
    if (kDebugMode) {
      print("POST REQUEST RESPONSE ${response.body}, ${response.statusCode}");
    }
    try{
      if (response.statusCode == 200) {
        Map<String, dynamic> responseJsonDecoded = jsonDecode(response.body);
        if(responseJsonDecoded["errors"] != null) {
          String message = responseJsonDecoded["errors"] == "" ? "Une erreur s'est produite" :  responseJsonDecoded["errors"];
          emit(PostApiFailure(message: message));
        } else {
          String message = responseJsonDecoded["errors"] == "" ? "Opération effectuée avec succès" : "";
          emit(PostApiSuccess(message: message));
        }
        if(responseJsonDecoded["data"] == 0) {
          String message = responseJsonDecoded["errors"] == "" ? "Opération effectuée avec succès" : "";
          emit(PostApiSuccess(message: message));
        }
      } else {
        String message = "Une erreur s'est produite";
        emit(PostApiFailure(message: message));
      }
    } catch(e, stacktrace){
      if (kDebugMode) {
        print("ERROR WHILE MAKING POST REQUEST $e");
      }
    }
  }
}

