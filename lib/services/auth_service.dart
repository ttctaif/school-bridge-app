import '../models/user_model.dart';
import 'api_service.dart';

class AuthService {
  final ApiService _api;
  UserModel? _currentUser;

  AuthService(this._api);

  UserModel? get currentUser => _currentUser;

  Future<UserModel> signIn(String username, String password) async {
    throw UnimplementedError();
  }

  Future<void> signOut() async {
    _api.setToken(null);
    _currentUser = null;
  }
}
