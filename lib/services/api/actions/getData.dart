import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/core/global.dart';

Future<dynamic> getApiData(endPoint,
    {Map<String, dynamic>? parameters, isGraphQl}) async {
  String url = BASE_URL;
  if (isGraphQl != true) {
    url = "${url}/$endPoint";
  } else {
    url = "${url}graphql";
  }
  Map<String, String>? headers = await getHeaders();
  var requestUri = Uri.parse(url).replace(queryParameters: parameters);
  if (kDebugMode) {
    print("API CALL LOGIN URI $requestUri");
  }
  var response = await http.get(requestUri, headers: headers);
  if (kDebugMode) {
    // print("API CALL RESPONSE ${response.body}");
    // print("API CALL RESPONSE HEADERS ${response.headers}");
  }
  return response;
}
