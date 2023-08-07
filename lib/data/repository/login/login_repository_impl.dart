import 'package:super_token/models/login_response.dart';

abstract class LoginRepositoryImpl {

  Future<AuthResponse> login(email, password);

}