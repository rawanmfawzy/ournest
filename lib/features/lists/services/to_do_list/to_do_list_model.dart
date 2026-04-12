class Todo {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final String dueDate;
  final int priority;
  final String category;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.dueDate,
    required this.priority,
    required this.category,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['isCompleted'],
      dueDate: json['dueDate'],
      priority: json['priority'],
      category: json['category'],
    );
  }
}