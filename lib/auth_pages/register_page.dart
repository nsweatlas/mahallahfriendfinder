import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth_service/auth.dart';
import '../models/firebase_settings.dart';
import '../models/member_profile.dart';

class RegisterPage extends StatefulWidget {
  final int userRoleId;
  const RegisterPage({super.key, required this.userRoleId});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final userEmailController = TextEditingController();
  final userPassController = TextEditingController();
  final userRePassController = TextEditingController();

  String? errorMessage = '';

  Future<void> handleCreateMemberProfile() async {
    final user = Auth().currentUser;
    String userId = user!.uid;
    bool isComplete = false;

    await membersProfileRef.doc(userId).set(
          MemberProfile(
            userId: userId,
            userEmail: userEmailController.text,
            isComplete: isComplete,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    // final appState = context.watch<AuthenticationStatus>();
    // myUser = appState.userProfile;
    return Scaffold(
      appBar: AppBar(title: const Text('Mahallah Friend Finder')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Text(
                        'Sign Up',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.always,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: userEmailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              hintText: "Your Email",
                              filled: true,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    style: BorderStyle.none,
                                    color: Colors.black),
                              ),
                            ),
                            style: const TextStyle(color: Colors.black),
                            validator: (String? value) {
                              return (value!.isEmpty || !value.contains('@'))
                                  ? '* Required Field - Email Format'
                                  : null;
                            },
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            controller: userPassController,
                            obscureText: true,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              hintText: "Password",
                              filled: true,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    style: BorderStyle.none,
                                    color: Colors.black),
                              ),
                            ),
                            style: const TextStyle(color: Colors.black),
                            onSaved: (String? value) {},
                            validator: (String? value) {
                              return (value!.isEmpty ||
                                      value.length < 6 ||
                                      value.length > 15)
                                  ? '* Required Field - 6-15 Length'
                                  : null;
                            },
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            controller: userRePassController,
                            obscureText: true,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              hintText: "Re Password",
                              filled: true,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    style: BorderStyle.none,
                                    color: Colors.black),
                              ),
                            ),
                            onSaved: (String? value) {},
                            validator: (String? value) {
                              if (value!.isEmpty ||
                                  value.length < 6 ||
                                  value.length > 15) {
                                return '* Required Field - 6-15 Length';
                              }
                              if (value != userPassController.text) {
                                return '* Password does not match';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(100, 15, 100, 15),
                          backgroundColor: Colors.green,
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        child: const Text(
                          'Next >>',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Cairo',
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context
                                .read<Auth>()
                                .createUserWithEmailAndPassword(
                                  email: userEmailController.text,
                                  password: userPassController.text,
                                )
                                .then((value) {
                              handleCreateMemberProfile();
                              Navigator.pop(context);
                            });
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(errorMessage!),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.red,
                              elevation: 0,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
