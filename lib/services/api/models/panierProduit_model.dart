import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yogivida_mobile/services/api/models/produit_model.dart';

part 'panierProduit_model.freezed.dart';
part 'panierProduit_model.g.dart';

@freezed
class PanierPProduit with _$PanierPProduit {
  const factory PanierPProduit({
    int? id,
    int? qte,
    double? prix,
    double? total,
    Produit? produit,
  }) = _PanierPProduit;

  factory PanierPProduit.fromJson(Map<String, dynamic> json) =>
      _$PanierPProduitFromJson(json);
}
