class CareArticle {
  final String id;
  final String title;
  final String category;
  final String summary;
  final String content;

  const CareArticle({
    required this.id,
    required this.title,
    required this.category,
    required this.summary,
    required this.content,
  });

  factory CareArticle.fromJson(Map<String, dynamic> json) {
    return CareArticle(
      id: json['id'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      summary: json['summary'] as String,
      content: json['content'] as String,
    );
  }
}