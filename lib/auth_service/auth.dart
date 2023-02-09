import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'auth_status.dart';

class Auth extends AuthenticationStatus {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  var memberProfile;

  //user & state persistance
  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  //email login
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
    // required BuildContext context,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    //signInWithPhoneNumber only for web-based applications?
  }

  //email sign up
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    // required BuildContext context,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }
}
