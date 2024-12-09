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
    if (!prefs.containsKey(table)) {
      return await prefs.setStringList(table, [encodedItem]) ? 1 : 0;
    }
    final encodedListGet = prefs.getStringList(table);
    encodedListGet!.add(encodedItem);
    return await prefs.setStringList(table, encodedListGet)
        ? encodedListGet.length
        : 0;
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
    Map<String, dynamic> item = {};
    final prefs = await SharedPreferences.getInstance();
    final List<String>? items = prefs.getStringList(table);
    if (items == null) return item;
    for (var element in items) {
      final itemDecoded = jsonDecode(element);
      if (itemDecoded['id'] == id) {
        item = itemDecoded;
      }
    }
    return item;
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
  Future<Object> delete({required Object id, required String table}) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(table) ? id : 0;
  }

  @override
  Future<int> deleteAll(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(key) ? 1 : 0;
  }

  @override
  Future<Object> searchDelete(String table, String criteria) async {
    final criteriaArray = criteria.split(':');
    final prefs = await SharedPreferences.getInstance();
    final List<String>? items = prefs.getStringList(table);
    if (items != null) {
      for (int i = 0; i < items.length; i++) {
        final item = jsonDecode(items[i]);
        if (item[criteriaArray[0]] == criteriaArray[1]) {
          items.removeAt(i);
          return await prefs.setStringList(table, items) ? item['id'] : 0;
        }
      }
    }
    return 0;
  }

  @override
  Future<Map<String, dynamic>> search(
      {required String table, required String criteria}) async {
    final criteriaArray = criteria.split(':');
    final prefs = await SharedPreferences.getInstance();
    final List<String>? items = prefs.getStringList(table);
    if (items != null) {
      for (int i = 0; i < items.length; i++) {
        final itemDecod = jsonDecode(items[i]);
        if (itemDecod[criteriaArray[0]] == criteriaArray[1]) {
          return itemDecod;
        }
      }
    }
    return {};
  }

  @override
  Future<List<Map<String, dynamic>>> searchAll({
    required String table,
    required String criteria,
  }) async {
    final criteriaArray = criteria.split(':');
    final prefs = await SharedPreferences.getInstance();
    final List<String>? items = prefs.getStringList(table);
    final List<Map<String, dynamic>> itemList = [];
    if (items != null) {
      for (int i = 0; i < items.length; i++) {
        final itemDecod = jsonDecode(items[i]);
        if (itemDecod[criteriaArray[0]] == criteriaArray[1]) {
          itemList.add(itemDecod);
        }
      }
    }
    return itemList;
  }

  @override
  Future<int> searchUpdate(
      {required String table,
      required String criteria,
      required Map<String, dynamic> updateItem}) async {
    final criteriaArray = criteria.split(':');
    final prefs = await SharedPreferences.getInstance();
    final List<String>? items = prefs.getStringList(table);
    if (items != null) {
      for (int i = 0; i < items.length; i++) {
        final itemDecod = jsonDecode(items[i]);
        if (itemDecod[criteriaArray[0]] == criteriaArray[1]) {
          items[i] = jsonEncode(updateItem);
        }
      }
    }
    return await prefs.setStringList(table, items!) ? 1 : 0;
  }

  @override
  Future<int> update(
      {required Map<String, dynamic> item, required String table}) async {
    final encodedItem = jsonEncode(item);
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(table)) {
      return 0;
    }
    final encodedListGet = prefs.getStringList(table);
    for (int i = 0; i < encodedListGet!.length; i++) {
      final itemDecoded = jsonDecode(encodedListGet[i]);
      if (itemDecoded['id'] == item['id']) {
        encodedListGet[i] = encodedItem;
        return await prefs.setStringList(table, encodedListGet)
            ? item['id']
            : 0;
      }
    }
    return 0;
  }

  @override
  Future<List<Map<String, dynamic>>> searchAllRaw({
    required String sql,
    List<Object?>? criteriaListData,
  }) {
    // TODO: implement searchAllRaw
    throw UnimplementedError();
  }
}
