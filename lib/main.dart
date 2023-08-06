import 'package:flutter/material.dart';
import 'package:super_token/ui/login_ui.dart';
import 'package:supertokens_flutter/supertokens.dart';

void main() {
  SuperTokens.init(apiDomain: "http://localhost:3001");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Super App',
      home: LoginUI(),
    );
  }
}
