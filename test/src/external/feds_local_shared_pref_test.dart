import 'dart:convert';

import 'package:feds/src/external/feds_local_shared_pref.dart';
import 'package:feds/src/feds_local.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  FedsLocal? datasource;
  setUp(() {
      WidgetsFlutterBinding.ensureInitialized();

      datasource = FedsLocalSharedPref();
  });
  test('get item', () async {

    const key = 'test';
    const item = {'id': 1, 'name': 'Jhon', 'age': 20};

    SharedPreferences.setMockInitialValues({key: [jsonEncode(item)]});

    final result = await datasource!.getItem(table: key, id: item['id'] as int);
    expect(result['id'], item['id']);
  });

  test('save item', () async {
    const key = 'test';
    const item = {'id': 1, 'name': 'Jhon', 'age': 20};

    SharedPreferences.setMockInitialValues({key: [jsonEncode(item)]});

    final result = await datasource!.save(table: key, item: item);
    expect(result, item['id']);
  });

  test('get item not found', () async {

    const key = 'test';
    const item = {'id': 1, 'name': 'Jhon', 'age': 20};

    SharedPreferences.setMockInitialValues({key: [jsonEncode(item)]});

    final result = await datasource!.getItem(table: key, id: 2);
    expect(result['id'], null);
  });

  test('search item', () async {

    const key = 'test';
    const criteria = 'name:Jhon';
    const item = {'id': 1, 'name': 'Jhon', 'age': 20};

    SharedPreferences.setMockInitialValues({key: [jsonEncode(item)]});

    final result = await datasource!.search(table: key, criteria: criteria);
    expect(result['id'], item['id']);
  });

  test('search item not found', () async {

    const key = 'test';
    const criteria = 'name:Gabriel';
    const item = {'id': 1, 'name': 'Jhon', 'age': 20};

    SharedPreferences.setMockInitialValues({key: [jsonEncode(item)]});

    final result = await datasource!.search(table: key, criteria: criteria);
    expect(result, {});
  });

  test('search all item', () async {

    const key = 'test';
    const criteria = 'name:Jhon';
    const item = {'id': 1, 'name': 'Jhon', 'age': 20};

    SharedPreferences.setMockInitialValues({key: [jsonEncode(item)]});

    final result = await datasource!.searchAll(table: key, criteria: criteria);
    expect(result[0]['id'], item['id']);
  });

  test('search all item not found', () async {
    
    const key = 'test';
    const criteria = 'name:Gabriel';
    const item = {'id': 1, 'name': 'Jhon', 'age': 20};

    SharedPreferences.setMockInitialValues({key: [jsonEncode(item)]});

    final result = await datasource!.searchAll(table: key, criteria: criteria);
    expect(result, []);
  });

  test('delete item', () async {
    
    const key = 'test';
    const item = {'id': 1, 'name': 'Jhon', 'age': 20};

    SharedPreferences.setMockInitialValues({key: [jsonEncode(item)]});

    final result = await datasource!.delete(table: key, id: item['id'] as int);
    expect(result, item['id']);
  });

  test('delete item not found', () async {
    
    const key = 'test';
    const item = {'id': 1, 'name': 'Jhon', 'age': 20};

    SharedPreferences.setMockInitialValues({key: [jsonEncode(item)]});

    final result = await datasource!.delete(table: key, id: 2);
    expect(result, 2);
  });

  test('delete all item', () async {
    
    const key = 'test';
    const item = {'id': 1, 'name': 'Jhon', 'age': 20};

    SharedPreferences.setMockInitialValues({key: [jsonEncode(item)]});

    final result = await datasource!.deleteAll(key);
    expect(result, 1);
  });

  // test('delete all item not found', () async {
    
  //   const key = 'test';
  //   const item = {'id': 1, 'name': 'Jhon', 'age': 20};

  //   SharedPreferences.setMockInitialValues({key: [jsonEncode(item)]});

  //   final result = await datasource!.deleteAll(key);
  //   expect(result, 0);
  // });

  test('update item', () async {
    
    const key = 'test';
    const item = {'id': 1, 'name': 'Jhon', 'age': 20};

    SharedPreferences.setMockInitialValues({key: [jsonEncode(item)]});

    final result = await datasource!.update(table: key, item: item);
    expect(result, item['id']);
  });

  test('update item not found', () async {
    
    const key = 'test';
    const item = {'id': 1, 'name': 'Jhon', 'age': 20};

    SharedPreferences.setMockInitialValues({key: [jsonEncode(item)]});

    final result = await datasource!.update(table: key, item: {'id': 2, 'name': 'Jhon', 'age': 20});
    expect(result, 2);
  });

  test('search update item', () async {

    const key = 'test';
    const criteria = 'name:Jhon';

    const item = {'id': 1, 'name': 'Jhon', 'age': 20};

    SharedPreferences.setMockInitialValues({key: [jsonEncode(item)]});
    
    final result = await datasource!.searchUpdate(
      table: key,
      criteria: criteria,
      updateItem: {'id': 2, 'name': 'Jhon', 'age': 20}
    );
    expect(result, item['id']);
  });

  test('search update item not found', () async {
    
    const key = 'test';
    const criteria = 'name:Jhon';

    const item = {'id': 1, 'name': 'Jhon', 'age': 20};

    SharedPreferences.setMockInitialValues({key: [jsonEncode(item)]});

    final result = await datasource!.searchUpdate(
      table: key,
      criteria: criteria,
      updateItem: {'id': 2, 'name': 'Jhon', 'age': 20}
    );
    expect(result, 1);
  });
}