import 'package:regexed_validator/regexed_validator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:super_token/models/login_response.dart';
import '../../data/repository/signup/signup_repository.dart';
import '../../utilities/bloc.dart';

class SignUpBloc extends Bloc {

  final _repo = SignUpRepository();

  final _showProgressSubject = BehaviorSubject<bool>();
  Stream<bool> get progressStatusObservable => _showProgressSubject.stream;

  final _signupSubject = PublishSubject<AuthResponse>();
  Stream<AuthResponse> get signupResponse => _signupSubject.stream;

  void login({required String email, required String password}) async {
    if (email.isEmpty) {
      _signupSubject.sink.addError('Email cannot be empty');
      return;
    }
    if(!validator.email(email)){
      _signupSubject.sink.addError("Please ensure you input a valid email");
      return;
    }
    if (password.isEmpty) {
      _signupSubject.sink.addError('Password cannot be empty');
      return;
    }
    try {
      _showProgressSubject.sink.add(true);
      await _repo.signup(email, password).then((response) {
        _signupSubject.sink.add(response);
        _showProgressSubject.sink.add(false);
      }, onError: (e) {
        _signupSubject.sink.addError(e);
        _showProgressSubject.sink.add(false);
      });
    } catch (e) {
      _signupSubject.sink.addError(e);
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