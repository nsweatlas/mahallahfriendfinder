import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mahallahfriendfinder/auth.dart';
import 'package:mahallahfriendfinder/widget_tree.dart';
import 'package:mahallahfriendfinder/widgets/ui_widget.dart';

class LoginPage extends StatefulWidget {
  final bool isLogin;
  final WidgetTree widgetTree;
  const LoginPage({super.key, required this.isLogin, required this.widgetTree});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == "user-not-found") {
          errorMessage =
              "User not found. Check if your email address is typed properly.";
        } else if (e.code == "wrong-password") {
          errorMessage = "Invalid password. Try again.";
        } else {
          errorMessage = e.message;
        }
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == "invalid-email") {
          errorMessage = "Invalid email. Try again.";
        } else {
          errorMessage = e.message;
        }
      });
    }
  }

  Widget _errorMessage() {
    return Column(
      children: <Widget>[
        sizedBox(0, 25),
        Text(
          errorMessage == '' ? '' : 'Error: $errorMessage',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _submitButton() {
    return ElevatedButton(
        onPressed: isLogin
            ? signInWithEmailAndPassword
            : createUserWithEmailAndPassword,
        child: Text(isLogin ? 'Login' : 'Sign Up'));
  }

  Widget _loginOrSignUpButton() {
    return TextButton(
        onPressed: () {
          setState(() {
            isLogin = !isLogin;
            widget.widgetTree.setIsLogin(isLogin);
          });
        },
        child: Text(isLogin ? 'Sign up instead' : 'Login instead'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            entryField('email', _controllerEmail),
            entryField('password', _controllerPassword),
            _errorMessage(),
            sizedBox(0, 20),
            _submitButton(),
            _loginOrSignUpButton(),
          ],
        ),
      ),
    );
  }
}
