import 'package:otp_verification_demo/success_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'OTP Verification Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        onGenerateRoute: (route) {
          switch (route.name) {
            case '/':
              return MaterialPageRoute(
                  builder: (context) => const MyHomePage());
            case '/success':
              return MaterialPageRoute(
                  builder: (context) => const SuccessScreen());
            default:
              return MaterialPageRoute(
                  builder: (context) => const MyHomePage());
          }
        },
        initialRoute: '/');
  }
}
