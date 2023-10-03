//import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';

import '../infra/feds_rest.dart';

class FedsRestDio implements FedsRest {
  final Dio http = Dio();
  
  Map<String, String> httpHeadersPost = {
    //HttpHeaders.contentTypeHeader: "application/json",
    "Connection": "Keep-Alive",
    "Accept": "application/json",
    "Content-Type": "application/json", //"application/x-www-form-urlencoded"
  };

  Map<String, String> httpHeadersGet = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  @override
  Future<Map<String, dynamic>> get(String url) async {
    http.options.responseType = ResponseType.json;
    try {
      var response = await http.get(url);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> post(
      String url, Map<String, dynamic> body) async {
    http.options.responseType = ResponseType.json;
    try {
      var response = await http.post(url,
          options: Options(headers: httpHeadersPost), queryParameters: body
          // body: json.encode(body),
          );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> put(
      String url, Map<String, dynamic> body) async {
    http.options.responseType = ResponseType.json;
    try {
      var response = await http.put(url,
          options: Options(headers: httpHeadersPost), queryParameters: body
          // body: json.encode(body),
          );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<int>> getData(String url) async {
    try {
      final response = await http.get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
        ),
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
