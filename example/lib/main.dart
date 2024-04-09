import 'package:flutter/material.dart';
import 'package:feds/feds.dart';

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
    FedsRest vartest = FedsRestHttp();

    vartest.post('url', {'body': 'body'});
    vartest.get('url');
    vartest.getData('url');

    FedsLocal datasourse = FedsLocalSharedPref();
    final item = {'id': 1, 'name': 'Jhon', 'age': 20};
    int id = await datasourse.save(table: 'test', item: item);
    if (id <= 0) {
      setState(() {
        text = 'Data not saved';
      });
    }
    final data = await datasourse.getItem(table: 'test', id: id);
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
