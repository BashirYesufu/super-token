import 'package:super_token/models/login_response.dart';

abstract class SignUpRepositoryImpl {

  Future<AuthResponse> signup(email, password);

}