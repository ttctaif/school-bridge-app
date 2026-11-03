enum InquiryStatus { pending, answered, closed }

enum InquiryCategory { academic, homework, absence, privateNote }

extension InquiryCategoryLabel on InquiryCategory {
  String get label => switch (this) {
        InquiryCategory.academic => 'أكاديمي',
        InquiryCategory.homework => 'واجب',
        InquiryCategory.absence => 'غياب',
        InquiryCategory.privateNote => 'ملاحظة خاصة',
      };
}

class InquiryModel {
  final String id;
  final String subjectId;

  /// Opaque id only; no contact data is ever stored on a ticket.
  final String parentId;

  /// First name only, shown to the teacher for context.
  final String studentName;
  final InquiryCategory category;
  final String question;
  final String? answer;
  final InquiryStatus status;
  final DateTime createdAt;

  const InquiryModel({
    required this.id,
    required this.subjectId,
    required this.parentId,
    required this.studentName,
    required this.category,
    required this.question,
    this.answer,
    this.status = InquiryStatus.pending,
    required this.createdAt,
  });

  InquiryModel copyWithAnswer(String answer) => InquiryModel(
        id: id,
        subjectId: subjectId,
        parentId: parentId,
        studentName: studentName,
        category: category,
        question: question,
        answer: answer,
        status: InquiryStatus.answered,
        createdAt: createdAt,
      );

  factory InquiryModel.fromJson(Map<String, dynamic> json) => InquiryModel(
        id: json['id'] as String,
        subjectId: json['subject_id'] as String,
        parentId: json['parent_id'] as String,
        studentName: json['student_name'] as String,
        category: InquiryCategory.values.byName(json['category'] as String),
        question: json['question'] as String,
        answer: json['answer'] as String?,
        status: InquiryStatus.values.byName(json['status'] as String),
        createdAt: DateTime.parse(json['created_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'subject_id': subjectId,
        'parent_id': parentId,
        'student_name': studentName,
        'category': category.name,
        'question': question,
        'answer': answer,
        'status': status.name,
        'created_at': createdAt.toIso8601String(),
      };
}
