import 'package:flutter/material.dart';
import 'package:mahallahfriendfinder/auth.dart';
import 'package:mahallahfriendfinder/pages/loginsuccess_page.dart';
import 'package:mahallahfriendfinder/pages/login_page.dart';

// ignore: must_be_immutable
class WidgetTree extends StatefulWidget {
  WidgetTree({
    super.key,
  });

  bool isLogin = true;

  void setIsLogin(bool isLogin) {
    this.isLogin = isLogin;
  }

  bool getIsLogin() {
    return isLogin;
  }

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChange,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return LoginSuccessPage(
            widgetTree: widget,
          );
        } else {
          return LoginPage(
            isLogin: widget.isLogin,
            widgetTree: widget,
          );
        }
      },
    );
  }
}
