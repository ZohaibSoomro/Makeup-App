import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mad_project/Screens/forget_password.dart';
import 'package:mad_project/Screens/home_screen.dart';
import 'package:mad_project/components/rectengular_button.dart';
import 'package:mad_project/constants.dart';

import 'Signup_screen.dart';

class Login extends StatefulWidget {
  static const String id = 'login_screen';
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? email;
  String? password;
  bool rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Epos',
                style: kTitleStyle,
              ),
              const SizedBox(
                height: 64,
              ),
              TextField(
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  prefixIcon: const IconTheme(
                      data: IconThemeData(color: Colors.black54),
                      child: Icon(Icons.email)),
                  hintText: 'Username or email',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  prefixIcon: const IconTheme(
                      data: IconThemeData(color: Colors.black54),
                      child: Icon(CupertinoIcons.lock_fill)),
                  hintText: 'Password',
                ),
                obscureText: true,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                      fillColor: MaterialStateProperty.all(Colors.white),
                      side: const BorderSide(color: Colors.black54),
                      checkColor: Colors.black54,
                      value: rememberMe,
                      onChanged: (bool? value) {
                        setState(() {
                          rememberMe = value!;
                        });
                      }),
                  Text(
                    'Remember me',
                    style: kTextStyle.copyWith(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, ForgetPassword.id);
                      },
                      child: const Text(
                        'Forgot password?',
                        style: kTextStyle,
                      ))
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              RectengularRoundedButton(
                color: Colors.purple,
                buttonName: 'Login',
                onPressed: () {
                  Navigator.pushNamed(context, HomeScreen.id);
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'New here?',
                    style: kTextStyle.copyWith(fontWeight: FontWeight.w500),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SignUp.id);
                      },
                      child: Text(
                        'Create an Account',
                        style: kTextStyle.copyWith(color: Colors.blueAccent),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
