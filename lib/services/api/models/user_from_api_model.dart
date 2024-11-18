import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_from_api_model.freezed.dart';
part 'user_from_api_model.g.dart';

@freezed
class UserFromApi with _$UserFromApi {
  const UserFromApi._();
  const factory UserFromApi({
    int? id,
    String? name,
  }) = _UserFromApi;

  factory UserFromApi.fromJson(Map<String, dynamic> json)  => _$UserFromApiFromJson(json);

}