## Feds

Feds - Flutter External Datasource: Flutter Package to work with external data source.

| **Support** | Android | iOS | Linux | macOS | Web | Windows |
|-------------|---------|------|-------|--------|-----|-------------|


## Features

interfaces:
- feds_cloud
- feds_local
- feds_rest

implementation:
- firabase
- shared_pref
- dio


## Getting started

2. To use this package, add inani as dependency in your `pubspec.yaml` file:

```yaml
dependencies:
   feds:
```

3. Import the package into your dart file:

```dart
import 'package:feds/feds.dart';
```


## Usage

```dart
  FedsLocal datasourse = FedsLocalSharedPref();
  final item = {'id': 1, 'name': 'Jhon', 'age': 20};
  int id = await datasourse.save(table: 'test', item: item);
  if (id <= 0) {
    print('Data not saved');
    return;
  }
  final data = await datasourse.getItem(id: id, table: 'test');
  print(data);

```


## Additional information

For any bugs, issues and more information, please contact the package authors on email: gvgabrielvieiragabrielvieira@gmail.com.
