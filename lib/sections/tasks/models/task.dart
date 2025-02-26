class Task {
  int? id;
  String title;
  String createdAt;
  String? dueDate;
  bool isCompleted;
  int? categoryId;

  Task({
    this.id,
    required this.title,
    required this.createdAt,
    this.dueDate,
    this.isCompleted = false,
    this.categoryId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'created_at': createdAt,
      'due_date': dueDate,
      'is_completed': isCompleted ? 1 : 0,
      'category_id': categoryId,
    };
  }

  // Create a Task object from a Map
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as int?,
      title: map['title'] as String,
      createdAt: map['created_at'] as String,
      dueDate: map['due_date'] as String?,
      isCompleted: (map['is_completed'] as int) == 1,
      categoryId: map['category_id'] as int?,
    );
  }
}
