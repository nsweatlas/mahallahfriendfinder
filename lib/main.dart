import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mahallahfriendfinder/widget_tree.dart';
import 'routes.dart';
import 'package:mahallahfriendfinder/pages/login_page.dart';
import 'package:mahallahfriendfinder/pages/loginsignup_page.dart';
import 'package:mahallahfriendfinder/pages/loginsuccess_page.dart';
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

  final String _title = 'Mahallah Friend Finder';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: WidgetTree(),
      // initialRoute: Routes.loginPage,
      routes: {
        Routes.signUpPage: (context) => const SignUpPage(),
        // Routes.loginPage: (context) => const LoginPage(),
        // Routes.loginSuccessPage: (context) => const LoginSuccessPage(),
        Routes.roomPage: (context) => RoomPage(
              title: _title,
            ),
        Routes.profilePage: (context) => const ProfilePage(
              title: '',
            ),
        Routes.logOutPage: (context) => const LogoutPage(),
      },
    );
  }
}
