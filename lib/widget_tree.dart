import 'package:flutter/material.dart';
import 'package:mahallahfriendfinder/auth.dart';
import 'package:mahallahfriendfinder/pages/room_page.dart';
import 'package:mahallahfriendfinder/pages/login_page.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  static const String _title = 'Mahallah Friend Finder';

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChange,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const RoomPage(title: WidgetTree._title);
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
