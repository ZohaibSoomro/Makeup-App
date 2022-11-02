import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/rectengular_button.dart';
import '../constants.dart';

class SignUp extends StatefulWidget {
  static const String id = 'signup_screen';
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? name;
  String? email;
  String? password;
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
                      child: Icon(Icons.person)),
                  hintText: 'Name',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  prefixIcon: const IconTheme(
                      data: IconThemeData(color: Colors.black54),
                      child: Icon(Icons.email)),
                  hintText: 'Email address',
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
                  hintText: 'Confirm Password',
                ),
                obscureText: true,
              ),
              const SizedBox(
                height: 40,
              ),
              RectengularRoundedButton(
                color: Colors.purple,
                buttonName: 'Sign Up',
                onPressed: () {},
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Flexible(
                    child: Divider(
                      height: 1,
                      color: Colors.black54,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('Or'),
                  ),
                  Flexible(
                    child: Divider(
                      height: 1,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60)),
                //margin: EdgeInsets.symmetric(horizontal: 20),
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Image.asset('assets/images/google.png')),
                        const SizedBox(width: 12),
                        const Text(
                          'Continue with Google',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
