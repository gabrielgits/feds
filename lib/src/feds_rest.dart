/// Abstract class FedsRest
/// This class is an abstract class that defines the interface for a REST API client.
library;

abstract class FedsRest {


  Future<Map<String, dynamic>> post({
    required String url,
    required Map<String, dynamic> body,
    String? token,
  });
  Future<Map<String, dynamic>> get(String url, {String? token});
  Future<Map<String, dynamic>> put({
    required String url,
    required Map<String, dynamic> body,
    String? token,
  });
  Future<List<int>> getData(String url, {String? token});
  Future<Map<String, dynamic>> delete(String url, {String? token});
}
