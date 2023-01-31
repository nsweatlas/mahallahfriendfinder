import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mahallahfriendfinder/auth.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({super.key, required this.title});

  final String title;

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
