class CategoryModel {
  int? id;
  String categoryName;
  String? createdAt;

  CategoryModel({
    this.id,
    required this.categoryName,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category_name': categoryName,
      'created_at': createdAt,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as int?,
      categoryName: map['category_name'] as String,
      createdAt: map['created_at'] as String?,
    );
  }
}
