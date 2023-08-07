import 'package:regexed_validator/regexed_validator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:super_token/models/login_response.dart';
import '../../data/repository/login/login_repository.dart';
import '../../utilities/bloc.dart';

class LoginBloc extends Bloc {

  final _repo = LoginRepository();

  final _showProgressSubject = BehaviorSubject<bool>();
  Stream<bool> get progressStatusObservable => _showProgressSubject.stream;

  final _loginSubject = PublishSubject<AuthResponse>();
  Stream<AuthResponse> get loginResponse => _loginSubject.stream;

  void login({required String email, required String password}) async {
    if (email.isEmpty) {
      _loginSubject.sink.addError('Email cannot be empty');
      return;
    }
    if(!validator.email(email)){
      _loginSubject.sink.addError("Please ensure you input a valid email");
      return;
    }
    if (password.isEmpty) {
      _loginSubject.sink.addError('Password cannot be empty');
      return;
    }
    try {
      _showProgressSubject.sink.add(true);
        await _repo.login(email, password).then((response) {
          _loginSubject.sink.add(response);
          _showProgressSubject.sink.add(false);
        }, onError: (e) {
          _loginSubject.sink.addError(e);
          _showProgressSubject.sink.add(false);
        });
    } catch (e) {
      _loginSubject.sink.addError(e);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void init() {
    // TODO: implement init
  }

}