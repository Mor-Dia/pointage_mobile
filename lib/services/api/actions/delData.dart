import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/core/global.dart';

Future<dynamic> delApiData(endPoint, Map<String, dynamic> body) async {
  String url = BASE_URL;
  url = "${url}${endPoint}";

  Map<String, String>? headers = await getHeaders();
  final bodyJson = jsonEncode((body));

  var requestUri = Uri.parse(url);
  if (kDebugMode) {
    print("API CALL LOGIN URI $requestUri");
    print("API CALL BODY $bodyJson");
  }
  var response = await http.delete(requestUri, headers: headers, body: bodyJson);
  if (kDebugMode) {
    // print("API CALL RESPONSE ${response.body}");
    // print("API CALL RESPONSE HEADERS ${response.headers}");
  }

  return response;
}
