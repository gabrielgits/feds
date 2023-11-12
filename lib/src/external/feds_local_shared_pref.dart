import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../feds_local.dart';

class FedsLocalSharedPref implements FedsLocal {
  @override
  Future<int> save({
    required Map<String, dynamic> item,
    required String table,
  }) async {
    final encodedItem = jsonEncode(item);
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(table, encodedItem) ? item['id'] : 0;
  }

  @override
  Future<int> saveAll({
    required List<Map<String, dynamic>> items,
    required String table,
  }) async {
    final tableCount = '${table}Count';
    final prefs = await SharedPreferences.getInstance();
    int count = prefs.getInt(tableCount) ?? 0;
    for (int i = 0; i < items.length; i++) {
      final id = items[i]['id'];
      if (id == null || id == 0) {
        count++;
        items[i]['id'] = count;
      }
    }
    final encodedList = jsonEncode(items);
    if (await prefs.setString(table, encodedList)) {
      return await prefs.setInt(tableCount, count) ? count : 0;
    }
    return 0;
  }

  @override
  Future<Map<String, dynamic>> getItem({
    required int id,
    required String table,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = prefs.getString(table);
    final decoded = jsonDecode(encoded!);
    return decoded;
  }

  @override
  Future<List<Map<String, dynamic>>> getAll(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedList = prefs.getString(key);
    final decodedList = jsonDecode(encodedList!) as List<dynamic>;
    final itemList =
        decodedList.map((item) => item as Map<String, dynamic>).toList();
    return itemList;
  }

  @override
  Future<int> delete({required int id, required String table}) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(table) ? id : 0;
  }

  @override
  Future<int> deleteAll(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(key) ? 1 : 0;
  }

  @override
  Future<int> searchDelete(String table, String criteria) async {
    // TODO: implement searchDelete
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> search(
      {required String table, required String criteria}) {
    // TODO: implement searchItem
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> searchAll(
      {required String table,
      required String criteria,
      List<Object?>? criteriaListData}) {
    // TODO: implement searchItems
    throw UnimplementedError();
  }

  @override
  Future<int> searchUpdate(
      {required String table,
      required String criteria,
      required Map<String, dynamic> item}) {
    // TODO: implement searchUpdateItem
    throw UnimplementedError();
  }

  @override
  Future<int> update(
      {required Map<String, dynamic> item, required String table}) async {
    final encodedItem = jsonEncode(item);
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(table, encodedItem) ? item['id'] : 0;
  }
}
