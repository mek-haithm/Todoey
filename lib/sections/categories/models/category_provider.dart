import 'package:flutter/foundation.dart';
import 'package:todey/sections/categories/models/category_model.dart';
import '../../../config/databases/database_helper.dart';

class CategoryProvider with ChangeNotifier {
  List<CategoryModel> _categories = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final Map<int, int> _taskCounts = {};

  List<CategoryModel> get categories => _categories;

  Future<void> fetchCategories() async {
    _categories = await _dbHelper.getCategories();
    await _updateTaskCounts();
    notifyListeners();
  }

  Future<void> addCategory(CategoryModel category) async {
    await _dbHelper.addCategory(category);
    await fetchCategories();
  }

  Future<void> deleteCategory(int id) async {
    await _dbHelper.deleteCategory(id);
    await fetchCategories();
  }

  int getTaskCount(int categoryId) {
    return _taskCounts[categoryId] ?? 0;
  }

  Future<void> _updateTaskCounts() async {
    for (var category in _categories) {
      _taskCounts[category.id!] =
      await _dbHelper.getTaskCountByCategory(category.id!);
    }
  }

  // This is the new public method to update task counts and notify listeners
  Future<void> updateTaskCounts() async {
    await _updateTaskCounts();
    notifyListeners();
  }
}
