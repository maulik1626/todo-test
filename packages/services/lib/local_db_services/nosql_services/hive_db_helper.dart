import 'package:hive/hive.dart';
import 'dart:developer' as developer;

mixin HiveDBHelper {
  static const String boxKeyMappingName = 'box_key_mapping';

  /// Stores the key associated with a specific Hive box.
  ///
  /// This method creates a separate box (`box_key_mapping`) to store the association
  /// between box names and their corresponding keys.
  ///
  /// Throws an exception and logs an error message if an issue occurs during the process.
  Future<void> storeBoxKey(String boxName, int key) async {
    Box<int>? boxKeyMappingBox;

    try {
      // Open the Hive box for storing box-key mapping
      boxKeyMappingBox = await Hive.openBox<int>(boxKeyMappingName);

      // Store the association between box name and key
      await boxKeyMappingBox.put(boxName, key);
      developer.log('Box key stored: Box: $boxName, Key: $key');
    } catch (error, stackTrace) {
      // Log an error message if an exception occurs during key storage
      developer.log(
        'An error occurred in storing box key: $error',
        error: error,
        stackTrace: stackTrace,
      );

      // Rethrow the exception after logging
      rethrow;
    } finally {
      // Close the box for storing box-key mapping to release resources
      if (boxKeyMappingBox != null && boxKeyMappingBox.isOpen) {
        await boxKeyMappingBox.close();
      }
    }
  }

  /// Retrieves the key associated with a specific Hive box.
  ///
  /// Returns `null` if the key is not found.
  ///
  /// Throws an exception and logs an error message if an issue occurs during the process.
  Future<int?> retrieveBoxKey(String boxName) async {
    Box<int>? boxKeyMappingBox;

    try {
      // Open the Hive box for storing box-key mapping
      boxKeyMappingBox = await Hive.openBox<int>(boxKeyMappingName);

      // Retrieve the key associated with the given box name
      return boxKeyMappingBox.get(boxName);
    } catch (error, stackTrace) {
      // Log an error message if an exception occurs during key retrieval
      developer.log(
        'An error occurred in retrieving box key: $error',
        error: error,
        stackTrace: stackTrace,
      );

      // Rethrow the exception after logging
      rethrow;
    } finally {
      // Close the box for storing box-key mapping to release resources
      if (boxKeyMappingBox != null && boxKeyMappingBox.isOpen) {
        await boxKeyMappingBox.close();
      }
    }
  }

  /// Saves data of type [T] to a Hive box with the given [boxName].
  ///
  /// Returns the key associated with the saved data.
  ///
  /// Throws an exception and logs an error message if an issue occurs during the process.
  Future<int> saveData<T>(String boxName, T data) async {
    Box<T>? box;
    int key = -1;

    try {
      // Open the Hive box
      box = await Hive.openBox<T>(boxName);

      // Add data to the box and capture the generated key
      key = await box.add(data);
      developer.log('Data saved in Hive Box $boxName.');
      developer.log('Data: ${data.toString()}');
    } catch (error, stackTrace) {
      // Log an error message if an exception occurs during data saving
      developer.log(
        'An error occurred in saving data to the database: $error',
        error: error,
        stackTrace: stackTrace,
      );

      // Rethrow the exception after logging
      rethrow;
    } finally {
      // Close the box to release resources
      if (box != null && box.isOpen) {
        await box.close();
      }

      // Vacuum the box to optimize storage
      await _vacuum(boxName);
    }

    return key;
  }

  /// Fetches a single data item of type [T] from a Hive box with the given [boxName] using the provided [key].
  ///
  /// Returns `null` if the key is not found.
  ///
  /// Throws an exception and logs an error message if an issue occurs during the process.
  Future<T?> fetchDataByKey<T>(String boxName, int key) async {
    Box<T>? box;

    try {
      // Open the Hive box
      box = await Hive.openBox<T>(boxName);

      // Fetch data using the provided key
      return box.get(key);
    } catch (error, stackTrace) {
      // Log an error message if an exception occurs during data fetching
      developer.log(
        'An error occurred in fetching data from the database: $error',
        error: error,
        stackTrace: stackTrace,
      );

      // Rethrow the exception after logging
      rethrow;
    } finally {
      // Close the box to release resources
      if (box != null && box.isOpen) {
        await box.close();
      }
    }
  }

  /// Updates an existing data item of type [T] in a Hive box with the given [boxName] using the provided [key].
  ///
  /// Throws an exception and logs an error message if an issue occurs during the process.
  Future<void> updateData<T>(String boxName, int key, T newData) async {
    Box<T>? box;

    try {
      // Open the Hive box
      box = await Hive.openBox<T>(boxName);

      // Update data using the provided key
      await box.put(key, newData);
    } catch (error, stackTrace) {
      // Log an error message if an exception occurs during data updating
      developer.log(
        'An error occurred in updating data in the database: $error',
        error: error,
        stackTrace: stackTrace,
      );

      // Rethrow the exception after logging
      rethrow;
    } finally {
      // Close the box to release resources
      if (box != null && box.isOpen) {
        await box.close();
      }
    }
  }

  /// Deletes a single data item of type [T] from a Hive box with the given [boxName] using the provided [key].
  ///
  /// Throws an exception and logs an error message if an issue occurs during the process.
  Future<void> deleteData<T>(String boxName, int key) async {
    Box<T>? box;

    try {
      // Open the Hive box
      box = await Hive.openBox<T>(boxName);

      // Delete data using the provided key
      await box.delete(key);
    } catch (error, stackTrace) {
      // Log an error message if an exception occurs during data deletion
      developer.log(
        'An error occurred in deleting data from the database: $error',
        error: error,
        stackTrace: stackTrace,
      );

      // Rethrow the exception after logging
      rethrow;
    } finally {
      // Close the box to release resources
      if (box != null && box.isOpen) {
        await box.close();
      }
    }
  }

  /// Fetches all data items of type [T] from a Hive box with the given [boxName].
  ///
  /// Throws an exception and logs an error message if an issue occurs during the process.
  Future<List<T>> fetchAllData<T>(String boxName) async {
    Box<T>? box;

    try {
      // Open the Hive box
      box = await Hive.openBox<T>(boxName);

      // Fetch all data from the box
      return box.values.toList();
    } catch (error, stackTrace) {
      // Log an error message if an exception occurs during data fetching
      developer.log(
        'An error occurred in fetching all data from the database: $error',
        error: error,
        stackTrace: stackTrace,
      );

      // Rethrow the exception after logging
      rethrow;
    } finally {
      // Close the box to release resources
      if (box != null && box.isOpen) {
        await box.close();
      }
    }
  }

  /// Vacuum the Hive box with the given [boxName] to optimize storage.
  Future<void> _vacuum(String boxName) async {
    Box? box;

    try {
      await Hive.openBox(boxName);
      box = Hive.box(boxName);

      // Compact the box to optimize storage
      await box.compact();
    } catch (error, stackTrace) {
      // Log an error message if an exception occurs during vacuuming
      developer.log(
        'An error occurred in vacuuming the Hive box: $error',
        error: error,
        stackTrace: stackTrace,
      );
    } finally {
      // Close the box to release resources
      if (box != null && box.isOpen) {
        await box.close();
      }
    }
  }
}