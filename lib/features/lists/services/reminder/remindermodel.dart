class ReminderModel {
  final String id;
  final String title;
  final String description;
  final DateTime reminderDateTime;
  final bool isCompleted;

  ReminderModel({
    required this.id,
    required this.title,
    required this.description,
    required this.reminderDateTime,
    required this.isCompleted,
  });

  factory ReminderModel.fromJson(Map<String, dynamic> json) {
    return ReminderModel(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? "",
      reminderDateTime: DateTime.parse(json['reminderDateTime']),
      isCompleted: json['isCompleted'],
    );
  }
}