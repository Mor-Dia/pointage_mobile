import 'package:freezed_annotation/freezed_annotation.dart';

class ImageLinkConverter implements JsonConverter<String?, String?> {
  const ImageLinkConverter();

  @override
  String? fromJson(String? json) {
    if (json != null) {
      if(json.startsWith("http")){
        return json;
      } else {
        return "";
      }
    }
    return null;
  }

  @override
  String toJson(String? data) => data??"";
}