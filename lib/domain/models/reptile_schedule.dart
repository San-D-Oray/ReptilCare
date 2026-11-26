  class ReptileSchedule {
  final String id;
  final String title;
  final String category; // 'Ular', 'Cicak/Gecko', 'Kura-kura'
  final String day;      // 'Senin', 'Selasa', dll.
  final String time;     // '19:00 WIB'
  final String description;

  const ReptileSchedule({
    required this.id,
    required this.title,
    required this.category,
    required this.day,
    required this.time,
    required this.description,
  });

  // Fungsi copyWith untuk keperluan Edit/Ganti Jadwal
  ReptileSchedule copyWith({
    String? id,
    String? title,
    String? category,
    String? day,
    String? time,
    String? description,
  }) {
    return ReptileSchedule(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      day: day ?? this.day,
      time: time ?? this.time,
      description: description ?? this.description,
    );
  }

  factory ReptileSchedule.fromJson(Map<String, dynamic> json) {
    return ReptileSchedule(
      id: json['id'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      day: json['day'] as String,
      time: json['time'] as String,
      description: json['description'] as String,
    );
  }
}