import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:super_token/constant/super_color.dart';

import '../constant/super_json.dart';

class SuperScaffold extends StatefulWidget {
  final Stream<bool>? loadingStream;
  final Color? appBarColor;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final String? appBarTitle;
  final bool hasBackButton;
  final List<Widget>? trailing;
  final Widget? body;
  final AppBar? appBar;
  final CrossAxisAlignment crossAxisAlignment;

  const SuperScaffold({
    this.loadingStream,
    this.appBarColor,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.hasBackButton = true,
    this.appBarTitle,
    this.trailing,
    this.body,
    this.appBar,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    Key? key,
  }) : super(key: key);

  @override
  State<SuperScaffold> createState() => _SuperScaffoldState();
}

class _SuperScaffoldState extends State<SuperScaffold> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.loadingStream,
        builder: (context, AsyncSnapshot<bool> snapshot)  {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: WillPopScope(
              onWillPop: () async => false,
              child: BlurryModalProgressHUD(
                inAsyncCall: snapshot.data ?? false,
                opacity: 0.8,
                color: Colors.black,
                blurEffectIntensity: 2,
                progressIndicator: Center(
                  child: Lottie.asset(
                      SuperJson.loader,
                      repeat: true,
                      animate: true,
                      width: 200,
                      height: 200
                  ),
                ),
                child: Scaffold(
                  backgroundColor: widget.backgroundColor,
                  appBar: widget.appBar ??
                      AppBar(
                        backgroundColor: SuperColor.primaryColor,
                        title: widget.appBarTitle != null
                            ? Text(
                          widget.appBarTitle!,
                        )
                            : null,
                        actions: widget.trailing,
                        leading: widget.hasBackButton
                            ? InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                          ),
                        )
                            : null,
                      ),
                  body: widget.body,
                  bottomNavigationBar: widget.bottomNavigationBar,
                ),
              ),
            ),
          );
        }
    );
  }
}
