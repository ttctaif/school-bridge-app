import 'package:flutter/foundation.dart';

import 'announcement_model.dart';
import 'inquiry_model.dart';
import 'student_model.dart';
import 'subject_model.dart';

/// In-memory data store used by the MVP screens until a backend exists.
class MockData extends ChangeNotifier {
  MockData._();
  static final MockData instance = MockData._();

  static const currentParentId = 'p1';
  static const currentTeacherId = 't1';
  static const currentTeacherName = 'أ. نورة العتيبي';

  final List<StudentModel> students = const [
    StudentModel(
        id: 's1', name: 'سارة محمد', grade: 'الصف الخامس', className: 'أ'),
    StudentModel(
        id: 's2', name: 'ليان محمد', grade: 'الصف الثاني', className: 'ب'),
  ];

  final List<SubjectModel> subjects = const [
    SubjectModel(
        id: 'sub1',
        name: 'الرياضيات',
        teacherId: 't1',
        teacherName: 'أ. نورة العتيبي',
        classLabel: 'الصف الخامس / أ',
        workStart: '16:00',
        workEnd: '18:00'),
    SubjectModel(
        id: 'sub2',
        name: 'اللغة العربية',
        teacherId: 't2',
        teacherName: 'أ. هدى الشمري',
        classLabel: 'الصف الخامس / أ',
        workStart: '15:00',
        workEnd: '17:00'),
    SubjectModel(
        id: 'sub3',
        name: 'العلوم',
        teacherId: 't3',
        teacherName: 'أ. منى القحطاني',
        classLabel: 'الصف الخامس / أ',
        workStart: '17:00',
        workEnd: '19:00'),
    SubjectModel(
        id: 'sub4',
        name: 'الرياضيات',
        teacherId: 't1',
        teacherName: 'أ. نورة العتيبي',
        classLabel: 'الصف الثاني / ب',
        workStart: '16:00',
        workEnd: '18:00'),
    SubjectModel(
        id: 'sub5',
        name: 'القرآن الكريم',
        teacherId: 't4',
        teacherName: 'أ. رقية الحربي',
        classLabel: 'الصف الثاني / ب',
        workStart: '14:00',
        workEnd: '16:00'),
  ];

  late final List<AnnouncementModel> _announcements = [
    _ann('a1', 'sub1', AnnouncementType.homework, 'واجب الكسور',
        'حل التمارين من 1 إلى 6 صفحة 48 وتسليمها يوم الأحد.', 2),
    _ann('a2', 'sub1', AnnouncementType.summary, 'ملخص درس الكسور العشرية',
        'تعلمنا تحويل الكسور العادية إلى عشرية والعكس، مع أمثلة على المقارنة.', 26),
    _ann('a3', 'sub2', AnnouncementType.summary, 'ملخص درس الفاعل ونائب الفاعل',
        'راجعنا الفرق بينهما مع أمثلة تطبيقية على السبورة.', 5),
    _ann('a4', 'sub3', AnnouncementType.homework, 'تقرير عن دورة الماء',
        'إعداد تقرير من صفحة واحدة مع رسم توضيحي.', 30),
    _ann('a5', 'sub4', AnnouncementType.homework, 'واجب الجمع والطرح',
        'إكمال ورقة العمل المرفقة في الكتاب صفحة 20.', 8),
    _ann('a6', 'sub5', AnnouncementType.summary, 'مراجعة سورة الإخلاص',
        'تم تسميع السورة وشرح معانيها، يرجى المراجعة في المنزل.', 50),
  ];

  late final List<InquiryModel> _inquiries = [
    InquiryModel(
        id: 'q1',
        subjectId: 'sub1',
        parentId: 'p2',
        studentName: 'ريم',
        category: InquiryCategory.homework,
        question: 'هل يمكن تمديد موعد تسليم واجب الكسور يوماً واحداً؟',
        createdAt: DateTime.now().subtract(const Duration(hours: 3))),
    InquiryModel(
        id: 'q2',
        subjectId: 'sub1',
        parentId: 'p3',
        studentName: 'جود',
        category: InquiryCategory.academic,
        question: 'ابنتي تجد صعوبة في المقارنة بين الكسور، هل من تمارين إضافية؟',
        answer: 'بالتأكيد، سأرفع ورقة تدريب إضافية غداً.',
        status: InquiryStatus.answered,
        createdAt: DateTime.now().subtract(const Duration(days: 1))),
    InquiryModel(
        id: 'q3',
        subjectId: 'sub4',
        parentId: 'p4',
        studentName: 'غدير',
        category: InquiryCategory.absence,
        question: 'ابنتي ستتغيب غداً لظرف صحي، كيف تعوّض الدرس؟',
        createdAt: DateTime.now().subtract(const Duration(hours: 1))),
  ];

  AnnouncementModel _ann(String id, String subjectId, AnnouncementType type,
          String title, String body, int hoursAgo) =>
      AnnouncementModel(
          id: id,
          subjectId: subjectId,
          type: type,
          title: title,
          body: body,
          createdAt: DateTime.now().subtract(Duration(hours: hoursAgo)));

  List<SubjectModel> subjectsForStudent(StudentModel s) =>
      subjects.where((x) => x.classLabel == s.gradeLabel).toList();

  List<SubjectModel> subjectsForTeacher(String teacherId) =>
      subjects.where((x) => x.teacherId == teacherId).toList();

  SubjectModel subjectById(String id) => subjects.firstWhere((x) => x.id == id);

  List<AnnouncementModel> announcementsFor(String subjectId) =>
      _announcements.where((a) => a.subjectId == subjectId).toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

  AnnouncementModel? latestFor(String subjectId) {
    final list = announcementsFor(subjectId);
    return list.isEmpty ? null : list.first;
  }

  void addAnnouncement(AnnouncementModel a) {
    _announcements.add(a);
    notifyListeners();
  }

  List<InquiryModel> inquiriesForTeacher(String teacherId) {
    final ids = subjectsForTeacher(teacherId).map((s) => s.id).toSet();
    return _inquiries.where((q) => ids.contains(q.subjectId)).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  int pendingCountForTeacher(String teacherId) => inquiriesForTeacher(teacherId)
      .where((q) => q.status == InquiryStatus.pending)
      .length;

  List<InquiryModel> inquiriesForParent(String parentId, String subjectId) =>
      _inquiries
          .where((q) => q.parentId == parentId && q.subjectId == subjectId)
          .toList();

  void addInquiry(InquiryModel q) {
    _inquiries.add(q);
    notifyListeners();
  }

  void answerInquiry(String id, String answer) {
    final i = _inquiries.indexWhere((q) => q.id == id);
    if (i == -1) return;
    _inquiries[i] = _inquiries[i].copyWithAnswer(answer);
    notifyListeners();
  }

  String nextId(String prefix) =>
      '$prefix${DateTime.now().microsecondsSinceEpoch}';
}
