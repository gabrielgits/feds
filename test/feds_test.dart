import 'package:feds/src/external/feds_local_shared_pref.dart';
import 'package:feds/src/infra/feds_local.dart';
import 'package:flutter/widgets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FedsLocal datasourse = FedsLocalSharedPref();
  final item = {'id': 1, 'name': 'Jhon', 'age': 20};
  int id = await datasourse.save(table: 'test', item: item);
  if (id <= 0) {
    print('Data not saved');
  }
  final data = await datasourse.getItem(id: id, table: 'test');
  print(data);
}
