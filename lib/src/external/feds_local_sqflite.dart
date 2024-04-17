import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

import '../feds_local.dart';

class FedsLocalSqflite implements FedsLocal {
  static Database? _database;
  final String dbPath;

  const FedsLocalSqflite({required this.dbPath});

  Future<Database?> initDatabase(String dbPathLocation) async {
    if (_database != null) {
      return _database;
    }

    bool fileCreated = await File(dbPathLocation).exists();
    if (!fileCreated) {
      ByteData data = await rootBundle.load("assets/database/dbsfb.db");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(dbPathLocation).writeAsBytes(bytes);
    }
    _database = await openDatabase(dbPathLocation);
    return _database;
  }

  @override
  Future<int> delete({required int id, required String table}) async {
    final db = await initDatabase(dbPath);
    if (db != null &&
        await db.delete(table, where: 'id = ?', whereArgs: [id]) > 0) {
      return id;
    }
    return 0;
  }

  @override
  Future<int> deleteAll(String table) async {
    final db = await initDatabase(dbPath);
    if (db != null) {
      await db.execute('DELETE FROM $table');
      return 1;
    }
    return 0;
  }

  @override
  Future<List<Map<String, dynamic>>> getAll(String table) async {
    final db = await initDatabase(dbPath);
    if (db != null) {
      final list = await db.query(table);
      if (list.isNotEmpty) {
        return list;
      }
    }
    return [];
  }

  @override
  Future<Map<String, dynamic>> getItem(
      {required int id, required String table}) async {
    final db = await initDatabase(dbPath);
    if (db != null) {
      final list = await db.query(table, where: 'id = ?', whereArgs: [id]);
      if (list.isNotEmpty) {
        return list[0];
      }
    }
    return {};
  }

  @override
  Future<int> save(
      {required Map<String, dynamic> item, required String table}) async {
    final db = await initDatabase(dbPath);
    if (db != null && await db.insert(table, item) > 0) {
      return item['id'];
    }
    return 0;
  }

  @override
  Future<int> saveAll(
      {required List<Map<String, dynamic>> items,
      required String table}) async {
    final db = await initDatabase(dbPath);
    int quant = 0;
    if (db != null) {
      for (var element in items) {
        final result = await db.insert(table, element);
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
    final db = await initDatabase(dbPath);
    if (db != null) {
      final list = await db.query(table, where: criteria);
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
    final db = await initDatabase(dbPath);
    if (db != null) {
      final list = await db.query(
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
  Future<int> searchDelete(String table, String criteria) async {
    final db = await initDatabase(dbPath);
    if (db != null) {
      return await db.delete(table, where: criteria);
    }
    return 0;
  }

  @override
  Future<int> searchUpdate(
      {required String table,
      required String criteria,
      required Map<String, dynamic> updateItem}) async {
    final db = await initDatabase(dbPath);

    if (db != null) {
      return await db.update(table, updateItem, where: criteria);
    }
    return 0;
  }

  @override
  Future<int> update(
      {required Map<String, dynamic> item, required String table}) async {
    final db = await initDatabase(dbPath);

    if (db != null) {
      return await db
          .update(table, item, where: 'id = ?', whereArgs: [item['id']]);
    }
    return 0;
  }
}
