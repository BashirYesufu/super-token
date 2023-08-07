import 'package:flutter/material.dart';
import 'package:super_token/ui/blocs/login_bloc.dart';
import 'package:super_token/constant/super_color.dart';
import 'package:super_token/ui/widgets/super_button.dart';
import 'package:super_token/ui/widgets/super_field.dart';
import 'package:super_token/ui/widgets/super_scaffold.dart';
import 'home_ui.dart';

class ForgotPasswordUI extends StatefulWidget {
  const ForgotPasswordUI({super.key});

  @override
  State<ForgotPasswordUI> createState() => _ForgotPasswordUIState();
}

class _ForgotPasswordUIState extends State<ForgotPasswordUI> {

  TextEditingController emailTC = TextEditingController();
  TextEditingController passwordTC = TextEditingController();
  final LoginBloc _bloc = LoginBloc();

  @override
  void initState() {
    _bloc.loginResponse.listen((response) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return HomeUI();
      }));
    }, onError: (error){
      var snackBar = SnackBar(
        content: Text(error),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SuperScaffold(
      loadingStream: _bloc.progressStatusObservable,
      appBarTitle: 'Forgot Password',
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 40),
              child: Text(
                'Reset password',
                style: TextStyle(
                    fontSize: 28
                ),
              ),
            ),
            SuperField(
              label: 'Email',
              hintText: 'Enter Email',
              keyboardType: TextInputType.emailAddress,
              controller: emailTC,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: SuperButton(
                label: 'Reset',
                onTap: ()=> _bloc.login(email: emailTC.text, password: passwordTC.text),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Remember your password?, '),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: SuperColor.primaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}