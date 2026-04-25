class ReminderModel {
  final String id;
  final String title;
  final String description;
  final DateTime reminderDateTime;
  final bool isCompleted;
  final bool isSent;
  final String recurrencePattern;
  final String category;
  final bool sharedWithPartner;

  ReminderModel({
    required this.id,
    required this.title,
    required this.description,
    required this.reminderDateTime,
    required this.isCompleted,
    required this.isSent,
    required this.recurrencePattern,
    required this.category,
    required this.sharedWithPartner,
  });

  factory ReminderModel.fromJson(Map<String, dynamic> json) {
    return ReminderModel(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? "",
      reminderDateTime: DateTime.parse(json['reminderDateTime']),
      isCompleted: json['isCompleted'] ?? false,
      isSent: json['isSent'] ?? false,
      recurrencePattern: json['recurrencePattern'] ?? "None",
      category: json['category'] ?? "General",
      sharedWithPartner: json['sharedWithPartner'] ?? false,
    );
  }
}