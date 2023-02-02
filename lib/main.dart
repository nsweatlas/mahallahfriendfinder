import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mahallahfriendfinder/widget_tree.dart';
import 'pages/login_page.dart';
import 'pages/loginsuccess_page.dart';
import 'routes.dart';
import 'package:mahallahfriendfinder/pages/loginsignup_page.dart';
import 'package:mahallahfriendfinder/pages/room_page.dart';
import 'package:mahallahfriendfinder/pages/profile_page.dart';
import 'package:mahallahfriendfinder/pages/logout_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final String title = 'Mahallah Friend Finder';
  final bool isLogin = true;
  final double iconSize = 26.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: WidgetTree(),
      // initialRoute: Routes.loginPage,
      routes: {
        Routes.widgetTree: (context) => WidgetTree(),
        Routes.loginPage: (context) => LoginPage(
              isLogin: WidgetTree().isLogin,
              widgetTree: WidgetTree(),
            ),
        Routes.loginSuccessPage: (context) => LoginSuccessPage(
              widgetTree: WidgetTree(),
            ),
        Routes.signUpPage: (context) => const SignUpPage(),
        Routes.roomPage: (context) => RoomPage(
              title: title,
            ),
        Routes.profilePage: (context) => ProfilePage(
              title: title,
            ),
        Routes.logOutPage: (context) => const LogoutPage(),
      },
    );
  }
}
