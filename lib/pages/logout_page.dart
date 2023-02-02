import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mahallahfriendfinder/auth.dart';

class LogoutPage extends StatefulWidget {
  const LogoutPage({Key? key}) : super(key: key);

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

Future<void> signOut() async {
  await Auth().signOut();
}
