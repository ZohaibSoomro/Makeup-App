import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mad_project/Screens/cart_screen.dart';
import 'package:mad_project/Screens/forget_password.dart';
import 'package:mad_project/Screens/login_screen.dart';
import 'package:mad_project/db/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/Signup_screen.dart';
import 'Screens/home_screen.dart';

bool? isLoggedIn;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  await DbHelper.instance.database;
  isLoggedIn = prefs.getBool('isLoggedIn');
  runApp(
    const MakeupApp(),
  );
}

class MakeupApp extends StatelessWidget {
  const MakeupApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:
          isLoggedIn == null || !isLoggedIn! ? Login.id : HomeScreen.id,
      routes: {
        Login.id: (context) => const Login(),
        SignUp.id: (context) => const SignUp(),
        ForgetPassword.id: (context) => ForgetPassword(),
        HomeScreen.id: (context) => const HomeScreen(),
        CartScreen.id: (context) => const CartScreen(),
      },
    );
  }
}
