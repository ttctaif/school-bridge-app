class SubjectModel {
  final String id;
  final String name;
  final String teacherId;
  final String teacherName;

  /// Daily inquiry window, "HH:mm" format.
  final String workStart;
  final String workEnd;

  const SubjectModel({
    required this.id,
    required this.name,
    required this.teacherId,
    required this.teacherName,
    required this.workStart,
    required this.workEnd,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) => SubjectModel(
        id: json['id'] as String,
        name: json['name'] as String,
        teacherId: json['teacher_id'] as String,
        teacherName: json['teacher_name'] as String,
        workStart: json['work_start'] as String,
        workEnd: json['work_end'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'teacher_id': teacherId,
        'teacher_name': teacherName,
        'work_start': workStart,
        'work_end': workEnd,
      };
}
