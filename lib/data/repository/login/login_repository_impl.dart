import 'package:super_token/models/login_response.dart';

abstract class LoginRepositoryImpl {

  Future<LoginResponse> login(email, password);

}