abstract class FedsRest {
  Future<Map<String, dynamic>> post(String url, Map<String, dynamic> body);
  Future<Map<String, dynamic>> get(String url);
  Future<Map<String, dynamic>> put(String url, Map<String, dynamic> body);
  Future<List<int>> getData(String url);
}
