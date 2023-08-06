import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_token/super_button.dart';
import 'package:super_token/super_color.dart';
import 'package:super_token/super_field.dart';
import 'package:super_token/super_images.dart';
import 'package:super_token/super_password_field.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: SuperColor.primaryColor,
      ),
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
            ),
            SuperPasswordField(
              label: 'Password',
              hintText: 'Enter Password',
            ),
            SuperButton(
              label: 'Login',
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
                      children: [
                        SvgPicture.asset(SuperImages.apple),
                        Text('Apple')
                      ],
                    ),
                  ),
                ),
              ],
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
              Text('Sign up', style: TextStyle(
                color: SuperColor.primaryColor
              ),),
            ],
          ),
        ),
      ),
    );
  }
}