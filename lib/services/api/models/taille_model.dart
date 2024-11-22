import 'package:freezed_annotation/freezed_annotation.dart';

part 'taille_model.freezed.dart';
part 'taille_model.g.dart';

@freezed
class TaillProperties with _$TaillProperties {
  const factory TaillProperties({
    required int id,
    required String designation,
    required String abreviation,
  }) = _TaillProperties;

  factory TaillProperties.fromJson(Map<String, dynamic> json) =>
      _$TaillPropertiesFromJson(json);
}

@freezed
class Taille with _$Taille {
  const factory Taille({
    required int id,
    required int taille_id,
    required TaillProperties taille,
  }) = _Taille;

  factory Taille.fromJson(Map<String, dynamic> json) => _$TailleFromJson(json);
}
