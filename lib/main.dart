import 'package:flutter/material.dart';
import 'package:mad_project/Screens/cart_screen.dart';
import 'package:mad_project/Screens/forget_password.dart';
import 'package:mad_project/Screens/login_screen.dart';
import 'package:mad_project/components/shopping_cart_provider.dart';
import 'package:provider/provider.dart';

import 'Screens/Signup_screen.dart';
import 'Screens/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) {
        return ShoppingCartProvider();
      },
      child: Epos(),
    ),
  );
}

class Epos extends StatelessWidget {
  const Epos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Login.id,
      routes: {
        Login.id: (context) => Login(),
        SignUp.id: (context) => SignUp(),
        ForgetPassword.id: (context) => ForgetPassword(),
        HomeScreen.id: (context) => HomeScreen(),
        CartScreen.id: (context) => CartScreen(),
      },
    );
  }
}
