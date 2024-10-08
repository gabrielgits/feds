import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../feds_local.dart';

class FedsLocalSqfliteFfi implements FedsLocal {
  static Database? _database;
  final String dbPath;
  final String dbName;

  const FedsLocalSqfliteFfi({required this.dbPath, required this.dbName});

  Future<Database?> _initDatabase() async {
    if (_database != null) {
      return _database;
    }

    sqfliteFfiInit();
    final databaseFactory = databaseFactoryFfi;

    final deviceDbPath = await getApplicationSupportDirectory();
    final deviceDb = '${deviceDbPath.path}\\$dbName';
    final created = await databaseFactory.databaseExists(deviceDb);
    if (!created) {
      ByteData data = await rootBundle.load('$dbPath$dbName');
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(deviceDb).writeAsBytes(bytes);
    }
    _database = await databaseFactory.openDatabase(deviceDb);
    return _database;
  }

  @override
  Future<Object> delete({required Object id, required String table}) async {
    _database = await _initDatabase();
    if (_database != null &&
        await _database!.delete(table, where: 'id = ?', whereArgs: [id]) > 0) {
      return id;
    }
    return 0;
  }

  @override
  Future<int> deleteAll(String table) async {
    _database = await _initDatabase();
    if (_database != null) {
      await _database!.execute('DELETE FROM $table');
      return 1;
    }
    return 0;
  }

  @override
  Future<List<Map<String, dynamic>>> getAll(String table) async {
    _database = await _initDatabase();
    if (_database != null) {
      final list = await _database!.query(table);
      if (list.isNotEmpty) {
        return list;
      }
    }
    return [];
  }

  @override
  Future<Map<String, dynamic>> getItem(
      {required Object id, required String table}) async {
    _database = await _initDatabase();
    if (_database != null) {
      final list =
          await _database!.query(table, where: 'id = ?', whereArgs: [id]);
      if (list.isNotEmpty) {
        return list[0];
      }
    }
    return {};
  }

  @override
  Future<int> save(
      {required Map<String, dynamic> item, required String table}) async {
    _database = await _initDatabase();
    if (_database != null) {
      return await _database!.insert(table, item);
    }
    return 0;
  }

  @override
  Future<int> saveAll(
      {required List<Map<String, dynamic>> items,
      required String table}) async {
    _database = await _initDatabase();
    int quant = 0;
    if (_database != null) {
      for (var element in items) {
        final result = await _database!.insert(table, element);
        if (result < 1) {
          return quant;
        }
        quant++;
      }
    }
    return quant;
  }

  @override
  Future<Map<String, dynamic>> search(
      {required String table, required String criteria}) async {
    _database = await _initDatabase();
    if (_database != null) {
      final list = await _database!.query(table, where: criteria);
      if (list.isNotEmpty) {
        return list[0];
      }
    }
    return {};
  }

  @override
  Future<List<Map<String, dynamic>>> searchAll(
      {required String table,
      required String criteria,
      List<Object?>? criteriaListData}) async {
    _database = await _initDatabase();
    if (_database != null) {
      final list = await _database!.query(
        table,
        where: criteria,
        whereArgs: criteriaListData,
      );
      if (list.isNotEmpty) {
        return list;
      }
    }
    return [];
  }

  @override
  Future<List<Map<String, dynamic>>> searchAllRaw(
      {required String sql, List<Object?>? criteriaListData}) async {
    _database = await _initDatabase();
    if (_database != null) {
      final list = await _database!.rawQuery(
        sql,
        criteriaListData,
      );
      if (list.isNotEmpty) {
        return list;
      }
    }
    return [];
  }

  @override
  Future<int> searchDelete(String table, String criteria) async {
    _database = await _initDatabase();
    if (_database != null) {
      return await _database!.delete(table, where: criteria);
    }
    return 0;
  }

  @override
  Future<int> searchUpdate(
      {required String table,
      required String criteria,
      required Map<String, dynamic> updateItem}) async {
    _database = await _initDatabase();
    if (_database != null) {
      return await _database!.update(table, updateItem, where: criteria);
    }
    return 0;
  }

  @override
  Future<int> update(
      {required Map<String, dynamic> item, required String table}) async {
    _database = await _initDatabase();
    if (_database != null) {
      return await _database!.update(
        table,
        item,
        where: 'id = ?',
        whereArgs: [item['id']],
      );
    }
    return 0;
  }
}
