import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mahallahfriendfinder/auth.dart';
import 'package:mahallahfriendfinder/routes.dart';
import 'package:mahallahfriendfinder/widgets/ui_widget.dart';

class LogoutPage extends StatefulWidget {
  const LogoutPage({Key? key}) : super(key: key);

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  static const int counter = 5;
  double value = counter.toDouble();
  late Timer timer;

  void _ timer() {
    timer = Timer.periodic (const Duration(seconds:1), (timer) {
      setState(() {
        if (value <= 0){
          timer.cancel();
        }
        value--;
      });
    })
  }

  void _ timerPop (){
    timer = Timer.periodic(Duration(seconds: counter + 1), (timer) {
      Navigator.popUntil (context, ModalRoute.withName(Routes.loginPage));
    }
  }
  @override
  Widget build(BuildContext context) {
    _timer();
    _timerPop();
    return Scaffold(
      appBar: AppBar(
        title: const Text ('Logout'),
        centerTitle: true,
      )
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(30, 40, 30, 30),
        child: Column (children: <Widget>[
          Text ("You have successfully logged out. Redirecting in $value seconds..."),
          sizedBox(0,50),
          linearLoading(value/counter),
        ]),
      )
    );


    )
  }
}

Future<void> signOut() async {
  await Auth().signOut();
}
