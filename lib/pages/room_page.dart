import 'package:flutter/material.dart';
import 'package:mahallahfriendfinder/widgets/ui_widget.dart';
import 'package:mahallahfriendfinder/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mahallahfriendfinder/room.dart';
import 'logout_page.dart';
import '../routes.dart';

class RoomPage extends StatefulWidget {
  final String title;
  const RoomPage({super.key, required this.title});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  final User? user = Auth().currentUser;

  Widget _userUid() {
    return Text(user?.email ?? 'User email');
  }

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(widget.title),
          centerTitle: true,
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    signOut();
                    Navigator.pushNamed(context, Routes.logOutPage);
                  },
                  child: Icon(
                    Icons.exit_to_app,
                    size: iconSize,
                  ),
                )),
          ]),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(30),
        child: Column(children: <Widget>[
          _userUid(),
        ]),
      ),
    );
  }
}
