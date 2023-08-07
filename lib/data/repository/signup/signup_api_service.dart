import 'dart:async';
import '../../../models/login_response.dart';
import '../../api/api_constants.dart';
import '../../network_manager/network_manager.dart';

class SignUpApiService {

  final NetworkManager _networkManager = NetworkManager();

  Future<AuthResponse> signup(String email, String password) async {
    var completer = Completer<AuthResponse>();
    try {
      final response = await _networkManager.networkRequestManager(
        RequestType.POST,
        ApiConstant.signup,
        body: {
          "email": email,
          "password": password,
        },
      );
      if (response.success) {
        var result = AuthResponse.fromJson(response.data);
        completer.complete(result);
      }
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }
}