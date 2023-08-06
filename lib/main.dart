import 'package:flutter/material.dart';
import 'package:super_token/ui/login_ui.dart';
import 'package:supertokens_flutter/supertokens.dart';

import 'data/config.dart';

void main() {
  SuperTokens.init(
    apiDomain: "http://localhost:3001",
    apiBasePath: "/api",
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    BaseUrl.setEnvironment(Environment.DEV);

    return MaterialApp(
      title: 'Super App',
      home: LoginUI(),
    );
  }
}
