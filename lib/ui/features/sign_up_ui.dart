import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_token/ui/blocs/signup_bloc.dart';
import 'package:super_token/ui/features/login_ui.dart';
import 'package:super_token/constant/super_color.dart';
import 'package:super_token/constant/super_images.dart';
import 'package:super_token/ui/widgets/super_button.dart';
import 'package:super_token/ui/widgets/super_field.dart';
import 'package:super_token/ui/widgets/super_password_field.dart';
import 'package:super_token/ui/widgets/super_scaffold.dart';

import 'home_ui.dart';

class SignUpUI extends StatefulWidget {
  const SignUpUI({super.key});

  @override
  State<SignUpUI> createState() => _SignUpUIState();
}

class _SignUpUIState extends State<SignUpUI> {

  TextEditingController emailTC = TextEditingController();
  TextEditingController passwordTC = TextEditingController();
  final SignUpBloc _bloc = SignUpBloc();

  @override
  void initState() {
    _bloc.signupResponse.listen((response) {
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
      appBarTitle: 'Sign up',
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
                'Hello,',
                style: TextStyle(
                    fontSize: 28
                ),
              ),
            ),
            SuperField(
              label: 'Email',
              hintText: 'Enter Email',
              controller: emailTC,
              keyboardType: TextInputType.emailAddress,
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
              label: 'Signup',
              onTap: ()=> _bloc.signup(email: emailTC.text, password: passwordTC.text),
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
                    child: Text('or Sign up with'),
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
              Text('Already have an account, '),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginUI()));
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