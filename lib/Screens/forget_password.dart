import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mad_project/components/my_dialog.dart';
import 'package:mad_project/constants.dart';

import '../components/rectengular_button.dart';

class ForgetPassword extends StatefulWidget {
  static const String id = 'forget_password';
  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String? email;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  clearText() {
    emailController.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Form(
            key: formKey,
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
                TextFormField(
                  controller: emailController,
                  onChanged: (value) {
                    setState(() {
                      email = value.trim() ?? '';
                    });
                  },
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Enter your email";
                    }
                    if (!EmailValidator.validate(val.trim())) {
                      return "Enter a valid email address";
                    }
                    return null;
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
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        await FirebaseAuth.instance
                            .sendPasswordResetEmail(email: email!);
                        clearText();
                        showMyDialog(
                          context,
                          'Info.',
                          'Verification link sent successfully.',
                          isError: false,
                        );
                      } on FirebaseAuthException catch (e) {
                        print(e.code);
                        if (e.code == "user-not-found") {
                          showMyDialog(
                              context, 'Error!', 'Email not registered.');
                        } else if (e.code == "network-request-failed") {
                          showMyDialog(
                              context, 'Login Error!', 'No Interet Connection',
                              disposeAfterMillis: 700);
                        } else if (e.code == "invalid-email") {
                          showMyDialog(
                            context,
                            'Error!',
                            'Invalid email entered.',
                            disposeAfterMillis: 700,
                          );
                        }
                        print(e.code);
                      }
                    } else {
                      print("Validation failed!");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
