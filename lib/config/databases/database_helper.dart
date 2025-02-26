import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todey/sections/categories/models/category_model.dart';
import 'dart:io';
import '../../sections/tasks/models/task.dart';

class DatabaseHelper {
  static Database? _db;

  Future<Database?> get db async {
    _db ??= await initDB();
    return _db;
  }

  Future<Database?> initDB() async {
    try {
      String databasePath = await getDatabasesPath();
      String path = join(databasePath, 'todoey.db');

      if (kDebugMode) {
        print('Database is supposed to be at: $path');
      }

      Database myDB = await openDatabase(
        path,
        onCreate: _onCreate,
        version: 1,
        onUpgrade: _onUpgrade,
      );

      // Check if the database file actually exists
      bool dbExists = await File(path).exists();
      if (kDebugMode) {
        print('Database exists after initDB(): $dbExists at $path');
      }

      return myDB;
    } catch (e) {
      if (kDebugMode) {
        print('Error while initializing database: $e');
      }
      return null;
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    try {
      await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        created_at TEXT NOT NULL,
        due_date TEXT,
        is_completed INTEGER NOT NULL,
        category_id INTEGER,
        FOREIGN KEY (category_id) REFERENCES categories (id)
      )
      ''');

      await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category_name TEXT NOT NULL,
        created_at TEXT
      )
      ''');

      await db.insert(
        'categories',
        {'category_name': 'Personal'},
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
      await db.insert(
        'categories',
        {'category_name': 'Shopping'},
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
      await db.insert(
        'categories',
        {'category_name': 'Wishlist'},
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
      await db.insert(
        'categories',
        {'category_name': 'Work'},
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
      await db.insert(
        'categories',
        {'category_name': 'Study'},
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error while creating tables: $e');
      }
    }
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    try {
      // Drop the existing tables
      await db.execute('DROP TABLE IF EXISTS tasks');
      await db.execute('DROP TABLE IF EXISTS categories');

      // Recreate the tables
      await _onCreate(db, newVersion);
    } catch (e) {
      if (kDebugMode) {
        print('Error while upgrading database: $e');
      }
    }
  }

  // Add Task method
  Future<int> addTask(Task task, {int? categoryId}) async {
    final dbClient = await db;
    Map<String, dynamic> taskMap = task.toMap();
    if (categoryId != null) {
      taskMap['category_id'] = categoryId;
    }
    return await dbClient!.insert(
      'tasks',
      taskMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

// Get Tasks method
  Future<List<Task>> getTasks() async {
    final dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient!.query(
      'tasks',
      columns: [
        'id',
        'title',
        'created_at',
        'due_date',
        'is_completed',
        'category_id'
      ],
      orderBy: 'created_at DESC', // Order by created_at in descending order
    );

    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  // Get Categories method
  Future<List<Map<String, dynamic>>> getCategoriesForTask() async {
    final dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient!.query('categories');
    return maps;
  }

  // delete task method
  Future<int> deleteTask(int taskId) async {
    final dbClient = await db;
    return await dbClient!.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [taskId],
    );
  }

  // update task method
  Future<int> updateTask(Task task, {int? categoryId}) async {
    final dbClient = await db;
    Map<String, dynamic> taskMap = task.toMap();
    if (categoryId != null) {
      taskMap['category_id'] = categoryId;
    }
    return await dbClient!.update(
      'tasks',
      taskMap,
      where: 'id = ?',
      whereArgs: [task.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // get categories function
  Future<List<CategoryModel>> getCategories() async {
    final dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient!.query(
      'categories',
      columns: [
        'id',
        'category_name',
        'created_at',
      ],
      orderBy: 'created_at DESC',
    );

    return List.generate(maps.length, (i) {
      return CategoryModel.fromMap(maps[i]);
    });
  }

  // Add category method
  Future<int> addCategory(CategoryModel category) async {
    final dbClient = await db;
    Map<String, dynamic> taskMap = category.toMap();
    return await dbClient!.insert(
      'categories',
      taskMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // delete category method
  Future<int> deleteCategory(int categoryId) async {
    final dbClient = await db;
    return await dbClient!.delete(
      'categories',
      where: 'id = ?',
      whereArgs: [categoryId],
    );
  }

  // update category method
  Future<int> updateCategory(CategoryModel category) async {
    final dbClient = await db;
    Map<String, dynamic> taskMap = category.toMap();
    return await dbClient!.update(
      'categories',
      taskMap,
      where: 'id = ?',
      whereArgs: [category.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get Tasks method for a specific category
  Future<List<Task>> getTasksByCategory(int categoryId) async {
    final dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient!.query(
      'tasks',
      columns: [
        'id',
        'title',
        'created_at',
        'due_date',
        'is_completed',
        'category_id'
      ],
      where: 'category_id = ?',
      whereArgs: [categoryId],
      orderBy: 'created_at DESC', // Order by created_at in descending order
    );

    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  // get task count by a category
  Future<int> getTaskCountByCategory(int categoryId) async {
    final dbClient = await db;
    final count = Sqflite.firstIntValue(await dbClient!.rawQuery(
      'SELECT COUNT(*) FROM tasks WHERE category_id = ? AND is_completed = 0',
      [categoryId],
    ));

    return count ?? 0;
  }
}
