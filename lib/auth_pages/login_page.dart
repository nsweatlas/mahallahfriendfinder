import 'package:flutter/material.dart';
import '../ui_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth_service/auth.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  String? errorMessage = '';
  bool isLogin = true;
  bool visibilityObscured = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  late FocusNode emailFocus;
  late FocusNode passwordFocus;

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
        // context: context
      );
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
        email: _controllerEmail.text,
        password: _controllerPassword.text,
        // context: context
      );
      () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RegisterPage(userRoleId: 2),
            ),
          );
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
    if (errorMessage == '') {
      return sizedBox(0, 20);
    }

    return Column(
      children: <Widget>[
        sizedBox(0, 25),
        Text(
          errorMessage == '' ? '' : 'Error: $errorMessage',
          textAlign: TextAlign.center,
        ),
        sizedBox(0, 15)
      ],
    );
  }

  Widget _submitButton() {
    return ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            setState(() {
              errorMessage = '';
            });
            try {
              isLogin
                  ? signInWithEmailAndPassword()
                  : createUserWithEmailAndPassword();
            } on FirebaseAuthException catch (e) {
              errorMessage = e.message;
            }
          }
        },
        child: Text(isLogin ? 'Login' : 'Sign Up'));
  }

  Widget _loginOrSignUpButton() {
    return TextButton(
        onPressed: () {
          setState(() {
            isLogin = !isLogin;
          });
        },
        child: Text(isLogin ? 'Sign up instead' : 'Login instead'));
  }

  @override
  void initState() {
    super.initState();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String emailTitle = 'Email';
    String passwordTitle = 'Password';
    bool emailNull = false;
    bool passwordNull = false;

    return Scaffold(
        appBar: AppBar(
          title: Text(isLogin ? 'Login' : 'Sign Up'),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.fromLTRB(30, 40, 30, 30),
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _controllerEmail,
                  focusNode: emailFocus,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide:
                          const BorderSide(color: Color(0xff000000), width: 1),
                    ),
                    labelText: emailTitle,
                    hintText: emailTitle,
                    prefixIcon: Icon(
                      Icons.account_box,
                      size: iconSize,
                    ),
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      emailNull = true;
                      emailFocus.requestFocus();
                      return 'Please enter email address.';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                sizedBox(0, 20),
                TextFormField(
                  controller: _controllerPassword,
                  focusNode: passwordFocus,
                  obscureText: visibilityObscured,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(
                            color: Color(0xff000000), width: 1),
                      ),
                      labelText: passwordTitle,
                      hintText: passwordTitle,
                      prefixIcon: Icon(
                        Icons.lock,
                        size: iconSize,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            visibilityObscured = !visibilityObscured;
                          });
                        },
                        icon: Icon(
                          visibilityObscured
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: iconSize,
                        ),
                        padding: const EdgeInsets.only(right: 7),
                      )),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      passwordNull = true;
                      if (!emailNull) passwordFocus.requestFocus();
                      return 'Please enter password.';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.visiblePassword,
                ),
                _errorMessage(),
                _submitButton(),
                _loginOrSignUpButton(),
              ],
            ),
          ),
        ));
  }
}
