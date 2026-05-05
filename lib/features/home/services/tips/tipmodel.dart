class TipModel {
  final int id;
  final String title;
  final String content;
  final String category;
  final String? imageUrl;
  final int? targetWeek;

  TipModel({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    this.imageUrl,
    this.targetWeek,
  });

  factory TipModel.fromJson(Map<String, dynamic> json) {
    return TipModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      category: json['category'],
      imageUrl: json['imageUrl'],
      targetWeek: json['targetWeek'],
    );
  }
}