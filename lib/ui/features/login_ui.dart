import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_token/ui/blocs/login_bloc.dart';
import 'package:super_token/ui/features/sign_up_ui.dart';
import 'package:super_token/constant/super_color.dart';
import 'package:super_token/constant/super_images.dart';
import 'package:super_token/ui/widgets/super_button.dart';
import 'package:super_token/ui/widgets/super_field.dart';
import 'package:super_token/ui/widgets/super_password_field.dart';
import 'package:super_token/ui/widgets/super_scaffold.dart';

import 'forgot_password_ui.dart';
import 'home_ui.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {

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
      appBarTitle: 'Login',
      hasBackButton: false,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 40),
              child: Text(
                  'Hello, Welcome back',
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
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: SuperPasswordField(
                label: 'Password',
                hintText: 'Enter Password',
                controller: passwordTC,
              ),
            ),
            SuperButton(
              label: 'Login',
              onTap: ()=> _bloc.login(email: emailTC.text, password: passwordTC.text),
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordUI()));
              },
              child: Text('Forgot Password?'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 0.9,
                    ),
                  ),
                  Flexible(
                    child: Text('or Login with'),
                  ),
                  Flexible(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 0.9,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Flexible(
                  child: SuperButton(
                    backgroundColor: Colors.white,
                    borderColor: Colors.grey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: SvgPicture.asset(
                            SuperImages.google,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text('Google'),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: SuperButton(
                    backgroundColor: Colors.white,
                    borderColor: Colors.grey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: SvgPicture.asset(
                            SuperImages.apple,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text('Apple'),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: SuperButton(
                  backgroundColor: Colors.white,
                  borderColor: Colors.grey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: SvgPicture.asset(
                          SuperImages.facebook,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('Facebook'),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Don\'t have an account, '),
              InkWell(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpUI()));
                },
                child: Text(
                  'Sign up',
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