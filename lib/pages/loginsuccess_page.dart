import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mahallahfriendfinder/auth.dart';
import 'package:mahallahfriendfinder/widget_tree.dart';
import '../routes.dart';

// ignore: must_be_immutable
class LoginSuccessPage extends StatefulWidget {
  final WidgetTree widgetTree;
  const LoginSuccessPage({super.key, required this.widgetTree});

  @override
  State<LoginSuccessPage> createState() => _LoginSuccessPageState();
}

class _LoginSuccessPageState extends State<LoginSuccessPage> {
  final User? user = Auth().currentUser;

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
    return Text("Welcome, ${user?.email ?? 'User email'}! $text");
  }

  Widget _continueButton(bool isLogin) {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            String routeName = "";
            if (isLogin) {
              routeName = Routes.roomPage;
            } else {
              routeName = Routes.signUpPage;
            }
            Navigator.pushNamed(context, routeName);
          });
        },
        child: const Text("Continue"));
  }

// SchedulerBinding.instance.addPostFrameCallback((_) {
//   Navigator.of(context).pushNamed("login");
// });

  @override
  Widget build(BuildContext context) {
    bool isLogin = widget.widgetTree.isLogin;

    return Scaffold(
      appBar: AppBar(
        title: Text(isLogin ? 'Login Success' : 'Sign Up Success'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(30),
        child: Column(children: <Widget>[
          _welcomeText(isLogin),
          _continueButton(isLogin),
        ]),
      ),
    );
  }
}
