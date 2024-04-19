import 'package:feds/src/external/feds_local_sqflite.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';

const tableName = 'test';
const item = {'id': 1, 'name': 'Jhon', 'age': 20};

//Mock Database class
class MockDatabase extends Mock implements Database {
  // mock query method in Database class to return a list of item
  @override
  Future<List<Map<String, Object?>>> query(String table,
      {bool? distinct,
      List<String>? columns,
      String? where,
      List<Object?>? whereArgs,
      String? groupBy,
      String? having,
      String? orderBy,
      int? limit,
      int? offset}) async {
    return [item];
  }
}

void main() {
  // create FedsLocalSqflite to test, the dbPath doesn't matter becouse it's mocked
  // with MockDatabase
  FedsLocalSqflite datasource = const FedsLocalSqflite(dbPath: '');
  setUp(() {
    // replace the real database instace with MockDatabase
    FedsLocalSqflite.database = MockDatabase();
  });

  // create a test group to test all get methods in FedsLocalSqflite
  group('Get Values Tests', () {
    // test get item from database
    test('get item from database', () async {
      // call the get method in FedsLocalSqflite to test if return the correct item
      final result =
          await datasource.getItem(table: tableName, id: item['id'] as int);
      // check if the result is the correct item mocked
      // the id of the item must be the same as the id of the result
      expect(result['id'], item['id']);
    });
  });
}
