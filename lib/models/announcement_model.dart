enum AnnouncementType { summary, homework }

extension AnnouncementTypeLabel on AnnouncementType {
  String get label => this == AnnouncementType.summary ? 'ملخص' : 'واجب';
}

class AnnouncementModel {
  final String id;
  final String subjectId;
  final AnnouncementType type;
  final String title;
  final String body;
  final DateTime createdAt;

  const AnnouncementModel({
    required this.id,
    required this.subjectId,
    required this.type,
    required this.title,
    required this.body,
    required this.createdAt,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) =>
      AnnouncementModel(
        id: json['id'] as String,
        subjectId: json['subject_id'] as String,
        type: AnnouncementType.values.byName(json['type'] as String),
        title: json['title'] as String,
        body: json['body'] as String,
        createdAt: DateTime.parse(json['created_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'subject_id': subjectId,
        'type': type.name,
        'title': title,
        'body': body,
        'created_at': createdAt.toIso8601String(),
      };
}
