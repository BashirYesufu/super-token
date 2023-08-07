import 'dart:async';
import '../../../models/login_response.dart';
import '../../api/api_constants.dart';
import '../../network_manager/network_manager.dart';

class LoginApiService {

  final NetworkManager _networkManager = NetworkManager();

  Future<AuthResponse> login(String email, String password) async {
    var completer = Completer<AuthResponse>();
    try {
      // final response = await _networkManager.makeNetworkRequest(
      //   RequestType.POST,
      // //Replace this url
      //   ApiConstant.login,
      //   body: {
      //     "email": email,
      //     "password": password,
      //   },
      // );
      //
      // if (response.success) {
      //   var result = AuthResponse.fromJson(response.data);
      //   completer.complete(result);
      // }

      ///HERE
      Timer(Duration(seconds: 3), () {
        completer.complete(AuthResponse());
      });
      ///HERE

    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }
}