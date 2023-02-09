import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'auth_pages/register_page.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'members/member_home.dart';
import 'members/member_profile_create.dart';
// import 'package:mahallah/public_splash.dart';
import 'routes.dart';
import 'auth_pages/login_page.dart';
import 'auth_service/auth.dart';
import 'auth_service/auth_status.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  Provider.debugCheckInvalidValueType = null;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationStatus()),
        ChangeNotifierProvider(create: (_) => Auth()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final String title = 'Mahallah Friend Finder';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      // home: StreamBuilder(
      //   stream: Auth().authStateChange,
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       return const RegisterPage(
      //         userRoleId: 2,
      //       );
      //     } else {
      //       return LoginPage(isLogin: isLogin);
      //     }
      //   },
      // ),
      initialRoute: Routes.loginPage,
      routes: {
        Routes.loginPage: (context) => const LoginPage(),
        // Routes.loginSuccessPage: (context) => LoginSuccessPage(),
        // Routes.signUpPage: (context) => const SignUpPage(),
        // Routes.roomPage: (context) => RoomPage(),
        // Routes.profilePage: (context) => ProfilePage(),
        // Routes.logOutPage: (context) => const LogoutPage(),
      },
      home: SafeArea(
        child: Consumer<AuthenticationStatus>(
          builder: (context, appState, _) {
            Widget myHome = const LoginPage();
            switch (appState.loginState) {
              case ApplicationLoginState.loggedOut:
                myHome = const LoginPage();
                break;
              case ApplicationLoginState.memberProfile:
                myHome = const MemberProfileCreate();
                break;
              case ApplicationLoginState.memberHome:
                myHome = const MemberHome();
                break;
              default:
                myHome = const LoginPage();
            }
            return myHome;
          },
        ),
      ),
    );
  }
}
