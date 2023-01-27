import 'package:flutter/material.dart';
import 'routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Mahallah Friend Finder',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        initialRoute: Routes.firstScreen,
        routes: {
          //Routes.firstScreen: (context) => const FirstScreen(),
          //Routes.secondScreen: (context) => const SecondScreen(),
        });
  }
}
