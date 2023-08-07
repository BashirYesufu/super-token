import 'dart:async';
import '../../../models/login_response.dart';
import '../../api/api_constants.dart';
import '../../network_manager/network_manager.dart';

class LoginApiService {

  final NetworkManager _networkManager = NetworkManager();

  Future<LoginResponse> login(String email, String password) async {
    var completer = Completer<LoginResponse>();
    try {
      final response = await _networkManager.networkRequestManager(
        RequestType.GET,
        ApiConstant.login,
        body: {
          "email": email,
          "password": password,
        },
      );
      if (response.success) {
        var result = LoginResponse.fromJson(response.data);
        completer.complete(result);
      }
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }
}