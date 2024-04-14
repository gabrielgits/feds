import '../feds_local.dart';

class FedsLocalSqflite implements FedsLocal {
  @override
  Future<int> delete({required int id, required String table}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<int> deleteAll(String table) {
    // TODO: implement deleteAll
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> getAll(String table) {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> getItem(
      {required int id, required String table}) {
    // TODO: implement getItem
    throw UnimplementedError();
  }

  @override
  Future<int> save(
      {required Map<String, dynamic> item, required String table}) {
    // TODO: implement save
    throw UnimplementedError();
  }

  @override
  Future<int> saveAll(
      {required List<Map<String, dynamic>> items, required String table}) {
    // TODO: implement saveAll
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> search(
      {required String table, required String criteria}) {
    // TODO: implement search
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> searchAll(
      {required String table,
      required String criteria,
      List<Object?>? criteriaListData}) {
    // TODO: implement searchAll
    throw UnimplementedError();
  }

  @override
  Future<int> searchDelete(String table, String criteria) {
    // TODO: implement searchDelete
    throw UnimplementedError();
  }

  @override
  Future<int> searchUpdate(
      {required String table,
      required String criteria,
      required Map<String, dynamic> updateItem}) {
    // TODO: implement searchUpdate
    throw UnimplementedError();
  }

  @override
  Future<int> update(
      {required Map<String, dynamic> item, required String table}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
