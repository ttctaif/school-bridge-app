enum InquiryStatus { pending, answered, closed }

class InquiryModel {
  final String id;
  final String subjectId;
  final String parentId;
  final String question;
  final String? answer;
  final InquiryStatus status;
  final DateTime createdAt;

  const InquiryModel({
    required this.id,
    required this.subjectId,
    required this.parentId,
    required this.question,
    this.answer,
    this.status = InquiryStatus.pending,
    required this.createdAt,
  });

  factory InquiryModel.fromJson(Map<String, dynamic> json) => InquiryModel(
        id: json['id'] as String,
        subjectId: json['subject_id'] as String,
        parentId: json['parent_id'] as String,
        question: json['question'] as String,
        answer: json['answer'] as String?,
        status: InquiryStatus.values.byName(json['status'] as String),
        createdAt: DateTime.parse(json['created_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'subject_id': subjectId,
        'parent_id': parentId,
        'question': question,
        'answer': answer,
        'status': status.name,
        'created_at': createdAt.toIso8601String(),
      };
}
