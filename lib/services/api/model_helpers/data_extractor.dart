import 'package:freezed_annotation/freezed_annotation.dart';

class DataExtractor<T> implements JsonConverter<T?, String?> {
  final String dataToExtract;
  const DataExtractor({required this.dataToExtract});

  @override
  T? fromJson(String? json) {
    // if(json != null){
    //   print("CONVERTING JSON $json");
    // }
    print("CONVERTING JSON $json");
    return null;
  }

  @override
  String toJson(T? data) => "";
}