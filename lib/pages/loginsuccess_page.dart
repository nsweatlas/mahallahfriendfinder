import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mahallahfriendfinder/main.dart';
import 'package:mahallahfriendfinder/pages/room_page.dart';
import 'package:mahallahfriendfinder/widgets/ui_widget.dart';
import 'package:mahallahfriendfinder/widget_tree.dart';
import 'package:mahallahfriendfinder/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../routes.dart';
import 'loginsignup_page.dart';

// ignore: must_be_immutable
class LoginSuccessPage extends StatefulWidget {
  final WidgetTree widgetTree;
  const LoginSuccessPage({super.key, required this.widgetTree});

  @override
  State<LoginSuccessPage> createState() => _LoginSuccessPageState();
}

class _LoginSuccessPageState extends State<LoginSuccessPage> {
  final User? user = Auth().currentUser;
  static const int counter = 5;
  double value = counter.toDouble();
  Timer? timer;

  bool get isLogin => widget.widgetTree.isLogin;

  // Future<void> signOut() async {
  //   await Auth().signOut();
  // }

  // Widget _signOutButton() {
  //   return ElevatedButton(onPressed: signOut, child: const Text('Sign Out'));
  // }

  Widget _welcomeText(bool isLogin) {
    String text = "";
    if (isLogin) {
      text = "Login success!";
    } else {
      text = "Continue to registration?";
    }
    return Text(
      "Welcome, ${user?.email ?? 'User email'}! $text"
      "\nRedirecting in $value seconds...",
      textAlign: TextAlign.center,
    );
  }

  // SchedulerBinding.instance.addPostFrameCallback((_) {
  //   Navigator.of(context).pushNamed("login");
  // });
  //timer to change countdown value
  Widget _timerText() {
    timer = Timer(const Duration(seconds: 1), () {
      setState(() {
        value--;
      });
    });
    if (value <= 0) {
      timer!.cancel();
    }
    return Text(
      "${value.toInt()}",
      style: const TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
    );
  }

  Widget _stackLoading() {
    return sizedBoxChild(
        200,
        200,
        Stack(
          fit: StackFit.expand,
          children: [
            circleLoading(value / counter),
            Center(
              child: _timerText(),
            )
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    //timer for Navigation push/pop
    Timer(const Duration(seconds: counter + 1), () {
      setState(() {
        String routeName = "";
        if (isLogin) {
          routeName = Routes.roomPage;
        } else {
          routeName = Routes.signUpPage;
        }
        Navigator.of(context).pushNamed(routeName);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isLogin ? 'Login Success' : 'Sign Up Success'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(30, 40, 30, 30),
        child: Column(children: <Widget>[
          _welcomeText(isLogin),
          sizedBox(0, 50),
          _stackLoading(),
          //_continueButton(isLogin),
        ]),
      ),
    );
  }
}
