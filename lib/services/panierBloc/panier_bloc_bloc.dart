import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/services/api/actions/getData.dart';
import 'package:yogivida_mobile/services/api/actions/postData.dart';
import 'package:yogivida_mobile/services/api/models/panierProduit_model.dart';
import 'package:yogivida_mobile/services/api/models/panier_model.dart';
import 'package:yogivida_mobile/services/data_bloc/bloc/data_bloc.dart';
import 'package:yogivida_mobile/services/data_bloc/bloc/data_bloc_helpers.dart';
import 'package:http/http.dart' as http;

part 'panier_bloc_event.dart';
part 'panier_bloc_state.dart';
part 'panier_bloc_bloc.freezed.dart';

class PanierBlocBloc extends Bloc<PanierBlocEvent, PanierBlocState> {
  PanierBlocBloc() : super(PanierBlocState.initial()) {
    on<PanierStarted>(_onStarted);
    on<PostPanier>(_onPostPanier);
    on<RefreshPanier>(_onRefreshPanier);
  }

  // Gestion de l'événement PanierStarted
  void _onStarted(PanierStarted event, Emitter<PanierBlocState> emit) {
    emit(const PanierBlocState.initial());
  }

  // Gestion de l'événement PostPanier
  Future<void> _onPostPanier(
      PostPanier event, Emitter<PanierBlocState> emit) async {
    emit(const PanierBlocState.loading());

    try {
      final response = await postApiData('panier_client', event.body);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseJsonDecoded = jsonDecode(response.body);
        // emit(PanierBlocState.loaded(panier: responseJsonDecoded['panier']));
        print(responseJsonDecoded);
        if (responseJsonDecoded['errors'] != null) {
          add(PanierBlocEvent.refresh(token: event.token));
          print(responseJsonDecoded['errors'].runtimeType);
          emit(PanierBlocState.error(
              message: responseJsonDecoded['errors'].runtimeType != String
                  ? responseJsonDecoded['errors'][0]
                  : responseJsonDecoded['errors']));
        } else {
          add(PanierBlocEvent.refresh(token: event.token));
          emit(
              PanierBlocState.success(message: responseJsonDecoded['success']));
        }
        return;
      } else {
        emit(PanierBlocState.error(
            message: "Erreur lors de la récupération des donées"));
      }
    } catch (e) {
      emit(PanierBlocState.error(
          message: "Erreur lors de la récupération des donées"));
      print(e);
    }
  }

  Future<void> _onRefreshPanier(
      RefreshPanier event, Emitter<PanierBlocState> emit) async {
    Map<String, dynamic>? parameters;
    String endPoint = Panier.getEndpoint(isPagination: true);
    emit(const PanierBlocState.loading());

    parameters = {
      "query": DataBlocHelpers.generateGraphQLQuery(
          endPoint, Panier.shrinkedAttributs(),
          filter: {'token': event.token}, useMetadata: true)
    };

    try {
      final response =
          await getApiData(endPoint, parameters: parameters, isGraphQl: true);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseJsonDecoded = jsonDecode(response.body);
        var jsonData =
            responseJsonDecoded['data']['panierspaginated']['data'][0];
        print(jsonData);
        Panier data = Panier.fromJson(jsonData);
        emit(PanierBlocState.loaded(panier: data.panierProduit!));
      } else {
        emit(PanierBlocState.error(
            message: "Erreur lors de la récupération du panier 1"));
      }
    } catch (e) {
      print(e);
      emit(PanierBlocState.error(
          message: "Erreur lors de la récupération du panier"));
    }
  }
}
