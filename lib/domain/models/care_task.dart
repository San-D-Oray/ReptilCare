class CareTask {
  final String id;
  final String taskName;
  final String reptileName;
  final bool isCompleted;
  final String deadline;

  const CareTask({
    required this.id,
    required this.taskName,
    required this.reptileName,
    required this.isCompleted,
    required this.deadline,
  });

  CareTask copyWith({bool? isCompleted}) {
    return CareTask(
      id: id,
      taskName: taskName,
      reptileName: reptileName,
      isCompleted: isCompleted ?? this.isCompleted,
      deadline: deadline,
    );
  }

  factory CareTask.fromJson(Map<String, dynamic> json) {
    return CareTask(
      id: json['id'] as String,
      taskName: json['taskName'] as String,
      reptileName: json['reptileName'] as String,
      isCompleted: json['isCompleted'] as bool,
      deadline: json['deadline'] as String,
    );
  }
}