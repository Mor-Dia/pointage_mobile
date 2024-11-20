import 'package:freezed_annotation/freezed_annotation.dart';

part 'taille_model.g.dart';

@JsonSerializable()
class TaillProperties {
  int id;
  String designation;
  String abreviation;

  TaillProperties(this.id, this.designation, this.abreviation);

  factory TaillProperties.fromJson(Map<String, dynamic> json) =>
      _$TaillPropertiesFromJson(json);
  Map<String, dynamic> toJson() => _$TaillPropertiesToJson(this);
}

@JsonSerializable()
@freezed
class Taille {
  int id;
  int taille_id;
  TaillProperties taille;

  Taille(this.taille_id, this.taille, this.id);

  factory Taille.fromJson(Map<String, dynamic> json) => _$TailleFromJson(json);
  Map<String, dynamic> toJson() => _$TailleToJson(this);
}
