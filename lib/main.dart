import 'package:flutter/material.dart';
import 'package:jiokee/screens/home_screen.dart';
import 'package:jiokee/screens/login_screen.dart';
import 'package:jiokee/screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:jiokee/screens/verification_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login': (context) => LoginScreen(),
        'home': (context) => HomeScreen(),
        'signup': (context) => SignUpScreen(),
        'verify': (context) => VerificationScreen(),
      },
    );
  }
}
