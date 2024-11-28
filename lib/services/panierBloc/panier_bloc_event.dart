part of 'panier_bloc_bloc.dart';

@freezed
class PanierBlocEvent with _$PanierBlocEvent {
  const factory PanierBlocEvent.started() = PanierStarted;
  const factory PanierBlocEvent.postPanier(
      {required Map<String, dynamic> body,
      required String token}) = PostPanier;
  const factory PanierBlocEvent.refresh({required String token}) =
      RefreshPanier;
}
