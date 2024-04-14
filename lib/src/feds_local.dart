abstract class FedsLocal {
  ///Save an item in a table
  /// - Return the id of the item if the item was saved, 0 otherwise
  Future<int> save({
    required Map<String, dynamic> item,
    required String table,
  });
  Future<int> saveAll({
    required List<Map<String, dynamic>> items,
    required String table,
  });
  Future<List<Map<String, dynamic>>> getAll(String table);
  Future<Map<String, dynamic>> getItem({required int id, required String table});
  Future<List<Map<String, dynamic>>> searchAll({
    required String table,
    required String criteria,
  });
  Future<Map<String, dynamic>> search(
      {required String table, required String criteria});
  Future<int> searchUpdate({
    required String table,
    required String criteria,
    required Map<String, dynamic> updateItem,
  });
  Future<int> searchDelete(String table, String criteria);
  Future<int> update({
    required Map<String, dynamic> item,
    required String table,
  });
  Future<int> delete({required int id, required String table});
  Future<int> deleteAll(String table);
}
