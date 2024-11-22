//import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';

import '../feds_rest.dart';

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
  Future<Map<String, dynamic>> get(String url, {String? token}) async {

    http.options.responseType = ResponseType.json;
    if (token != null){
      http.options.headers["Authorization"] = "Bearer $token";
    }
    try {
      var response = await http.get(url);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> post(
      {
    required String url,
    required Map<String, dynamic> body,
    String? token,
  }) async {
    http.options.responseType = ResponseType.json;
    if (token != null){
      http.options.headers["Authorization"] = "Bearer $token";
    }
    try {
      var response = await http.post(
        url,
        data: body,
        options: Options(headers: httpHeadersPost),
        // body: json.encode(body),
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> put(      {
    required String url,
    required Map<String, dynamic> body,
    String? token,
  }) async {
    http.options.responseType = ResponseType.json;
        if (token != null){
      http.options.headers["Authorization"] = "Bearer $token";
    }
    try {
      var response = await http.put(
        url,
        data: body,
        options: Options(headers: httpHeadersPost),
        // body: json.encode(body),
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> delete(String url, {String? token}) async {
    http.options.responseType = ResponseType.json;
    if (token != null){
      http.options.headers["Authorization"] = "Bearer $token";
    }
    try {
      var response = await http.delete(url);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<int>> getData(String url, {String? token}) async {
    try {
      if (token != null){
      http.options.headers["Authorization"] = "Bearer $token";
    }
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
