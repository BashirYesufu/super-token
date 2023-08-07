import 'package:super_token/models/login_response.dart';
import 'login_api_service.dart';
import 'login_repository_impl.dart';

class LoginRepository implements LoginRepositoryImpl {

  final _service = LoginApiService();

  @override
  Future<AuthResponse> login(email, password) {
    return _service.login(email, password);
  }

}