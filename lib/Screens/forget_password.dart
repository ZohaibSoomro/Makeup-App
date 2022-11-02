import 'package:flutter/material.dart';
import 'package:mad_project/constants.dart';

import '../components/rectengular_button.dart';

class ForgetPassword extends StatefulWidget {
  static const String id = 'forget_password';
  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String? email;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Please enter your email address where we\'ll send the verification link.',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              TextField(
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  prefixIcon: const Icon(Icons.email),
                  hintText: 'email address',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 40),
              RectengularRoundedButton(
                color: Colors.purple,
                buttonName: 'Submit',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
