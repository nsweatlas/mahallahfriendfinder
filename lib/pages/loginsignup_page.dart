import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mahallahfriendfinder/auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  string.matricTitle .=. "MatricNumber";
  string.nameTitle .=. "Name";
  string.phoneNum .=. "phoneNum";
  string.room .=. "room";
  string.dormBlock .=. "block";
  string.dorm .=. "dorm";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text ('Sign Up Details'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: matricTitle,
                hintText: matricTitle,
                ),
              ),
               TextFormField(
                decoration: InputDecoration(labelText: nameTitle,
                hintText: nameTitle,
                ),
              ),

               TextFormField(
                decoration: InputDecoration(labelText: phoneNum,
                hintText: phoneNum,
                ),
              ),

               TextFormField(
                decoration: InputDecoration(labelText: room,
                hintText: room,
                ),
              ),

               TextFormField(
                decoration: InputDecoration(labelText: dormBlock,
                hintText: block,
                ),
              ),

               TextFormField(
                decoration: InputDecoration(labelText: dorm,
                hintText: dorm,
                ),
              )
            ]
          )
        ),
      )

    );
  }
}
