import 'package:feds/feds.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String text = 'Press the button';

  Future<void> saveData() async {
    const tableName = 'users';
    FedsLocal datasourse =
        const FedsLocalSqflite(dbPath: 'assets/', dbName: 'dbtest.db');
    final item = {
      'name': 'Jhon',
      'email': 'jhon@example.com',
      'password': '1234'
    };
    int id = await datasourse.save(table: tableName, item: item);
    if (id <= 0) {
      setState(() {
        text = 'Data not saved';
      });
    }
    final data = await datasourse.getItem(table: tableName, id: id);
    setState(() {
      text = data.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(text),
              ElevatedButton(
                onPressed: saveData,
                child: const Text('Press me'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
