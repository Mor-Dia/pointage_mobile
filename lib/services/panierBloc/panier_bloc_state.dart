part of 'panier_bloc_bloc.dart';

@freezed
class PanierBlocState with _$PanierBlocState {
  const factory PanierBlocState.initial() = PanierInitial;
  const factory PanierBlocState.loading() = PanierLoading;
  const factory PanierBlocState.success({required String message}) =
      PanierSuccess;
  const factory PanierBlocState.loaded({required List<PanierPProduit> panier}) =
      PanierLoaded;
  const factory PanierBlocState.error({required String message}) = PanierError;
}
