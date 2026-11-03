import '../models/announcement_model.dart';
import '../models/inquiry_model.dart';
import '../models/subject_model.dart';

/// Backend access layer. Replace the stubs with real HTTP calls.
class ApiService {
  final String baseUrl;
  String? _token;

  ApiService({required this.baseUrl});

  void setToken(String? token) => _token = token;

  bool get isAuthenticated => _token != null;

  Future<List<SubjectModel>> fetchSubjects() async {
    throw UnimplementedError();
  }

  Future<List<AnnouncementModel>> fetchAnnouncements(String subjectId) async {
    throw UnimplementedError();
  }

  Future<void> publishAnnouncement(AnnouncementModel announcement) async {
    throw UnimplementedError();
  }

  Future<List<InquiryModel>> fetchInquiries() async {
    throw UnimplementedError();
  }

  Future<void> submitInquiry(InquiryModel inquiry) async {
    throw UnimplementedError();
  }

  Future<void> answerInquiry(String inquiryId, String answer) async {
    throw UnimplementedError();
  }
}
