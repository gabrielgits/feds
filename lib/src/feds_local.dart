/// Abstract class FedsLocal
/// This class is an abstract class that defines the interface for a local storage.
library;

abstract class FedsLocal {
  ///Save an item in a table
  /// - Return the id of the item if the item was saved, 0 otherwise
  Future<Object> save({
    required Map<String, dynamic> item,
    required String table,
  });

  ///Save all items in a table
  /// - Return the number of items saved, 0 if there was an error
  Future<int> saveAll({
    required List<Map<String, dynamic>> items,
    required String table,
  });

  ///Get all items in a table
  /// - Return a list of all items in the table
  Future<List<Map<String, dynamic>>> getAll(String table);

  ///Get an item in a table
  /// - Return the item if found, an empty map otherwise
  Future<Map<String, dynamic>> getItem(
      {required Object id, required String table});

  ///Search all items with especific criteria in a table
  /// - Return a list of all items with the criteria, an empty list otherwise
  Future<List<Map<String, dynamic>>> searchAll({
    required String table,
    required String criteria,
  });

  ///Search an item with especific criteria in a table
  /// - Return the item if found, an empty map otherwise
  Future<Map<String, dynamic>> search(
      {required String table, required String criteria});

  ///Update an item in a table
  /// - Return 1 if the item was updated, 0 otherwise
  Future<int> searchUpdate({
    required String table,
    required String criteria,
    required Map<String, dynamic> updateItem,
  });

  ///Delete an item in a table
  /// - Return the id of the item if the item was deleted, 0 otherwise
  Future<Object> searchDelete(String table, String criteria);

  ///Update an item in a table
  /// - Return the id of the item if the item was updated, 0 otherwise
  Future<int> update({
    required Map<String, dynamic> item,
    required String table,
  });

  ///Delete an item in a table
  /// - Return the id of the item if the item was deleted, 0 otherwise
  Future<Object> delete({required Object id, required String table});

  ///Delete all items in a table
  /// - Return 1 if the items were deleted, 0 otherwise
  Future<int> deleteAll(String table);

  /// Perform a raw SQL query to search for all records
  /// based on the provided SQL query and criteria list data.
  /// - Return a list of all items with the criteria, an empty list otherwise
  Future<List<Map<String, dynamic>>> searchAllRaw({
    required String sql,
    List<Object?>? criteriaListData,
  });
}
