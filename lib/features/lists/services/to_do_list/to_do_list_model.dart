class TodoModel {
  final String id;
  final String title;
  final String? description;
  final bool isCompleted;
  final String? dueDate;
  final int priority;
  final String? category;
  final bool sharedWithPartner;

  TodoModel({
    required this.id,
    required this.title,
    this.description,
    required this.isCompleted,
    this.dueDate,
    required this.priority,
    this.category,
    required this.sharedWithPartner,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['isCompleted'],
      dueDate: json['dueDate'],
      priority: json['priority'] ?? 0,
      category: json['category'],
      sharedWithPartner: json['sharedWithPartner'] ?? false,
    );
  }
}