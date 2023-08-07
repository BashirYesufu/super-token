import 'package:flutter/material.dart';
import 'package:super_token/ui/features/login_ui.dart';
import 'package:super_token/ui/widgets/super_scaffold.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({super.key});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {

  @override
  Widget build(BuildContext context) {
    return SuperScaffold(
      appBarTitle: 'Home',
      hasBackButton: false,
      body: Center(
        child: InkWell(
          onTap: (){
            //User details is cleared here and routed to login
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginUI()), (route) => false);
          },
            child: Text('Logout'),
        ),
      ),
    );
  }
}