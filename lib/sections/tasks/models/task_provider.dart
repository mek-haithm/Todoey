import 'package:flutter/foundation.dart';
import 'package:todey/sections/categories/models/category_provider.dart';
import '../../../config/databases/database_helper.dart';
import 'task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  List<Task> _categoryTasks = [];

  List<Map<String, dynamic>> _categories = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();

  List<Task> get tasks => _tasks;
  List<Map<String, dynamic>> get categories => _categories;
  List<Task> get categoryTasks => _categoryTasks;

  Future<void> fetchCategoryTasks(int categoryId) async {
    _categoryTasks = await _dbHelper.getTasksByCategory(categoryId);
    notifyListeners();
  }

  Future<void> fetchTasks() async {
    _tasks = await _dbHelper.getTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task,
      {int? categoryId, CategoryProvider? categoryProvider}) async {
    await _dbHelper.addTask(task);
    if (categoryId != null) {
      fetchCategoryTasks(categoryId);
    }
    if (categoryProvider != null) {
      categoryProvider.updateTaskCounts();
    }
    await fetchTasks();
  }

  Future<void> deleteTask(int id,
      {int? categoryId, CategoryProvider? categoryProvider}) async {
    await _dbHelper.deleteTask(id);
    if (categoryId != null) {
      fetchCategoryTasks(categoryId);
    }
    if (categoryProvider != null) {
      categoryProvider.updateTaskCounts();
    }
    await fetchTasks();
  }

  Future<void> updateTask(Task task,
      {int? categoryId, CategoryProvider? categoryProvider}) async {
    await _dbHelper.updateTask(task);
    if (categoryId != null) {
      fetchCategoryTasks(categoryId);
    }
    if (categoryProvider != null) {
      categoryProvider.updateTaskCounts();
    }
    await fetchTasks();
  }

  Future<void> toggleTaskCompletion(int taskId) async {
    try {
      Task task = _tasks.firstWhere((t) => t.id == taskId);
      task.isCompleted = !task.isCompleted;
      await updateTask(task);
    } catch (e) {
      if (kDebugMode) {
        print("Task with ID $taskId not found.");
      }
    }
  }

  Future<void> toggleCategoryTaskCompletion(int taskId,
      {required CategoryProvider categoryProvider}) async {
    try {
      Task categoryTask = _categoryTasks.firstWhere((t) => t.id == taskId);
      categoryTask.isCompleted = !categoryTask.isCompleted;
      await updateTask(categoryTask);
      await categoryProvider.fetchCategories();
    } catch (e) {
      if (kDebugMode) {
        print("Task with ID $taskId not found.");
      }
    }
  }

  Future<void> getCategoriesForTasks() async {
    _categories = await _dbHelper.getCategoriesForTask();
    notifyListeners();
  }
}
