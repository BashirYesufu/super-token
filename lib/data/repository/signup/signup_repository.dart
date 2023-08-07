import 'package:super_token/data/repository/signup/signup_api_service.dart';
import 'package:super_token/data/repository/signup/signup_repository_impl.dart';
import 'package:super_token/models/login_response.dart';

class SignUpRepository implements SignUpRepositoryImpl {

  final _service = SignUpApiService();

  @override
  Future<AuthResponse> signup(email, password) {
    return _service.signup(email, password);
  }

}