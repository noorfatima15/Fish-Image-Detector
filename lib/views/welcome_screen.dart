import 'package:fish_detector/views/signin_screen.dart';
import 'package:fish_detector/views/singn_up_screen.dart';
import 'package:flutter/material.dart';

import '../utils/text_styles.dart';
import '../widgets/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: WillPopScope(
        onWillPop: () async => false,
        child: Center(
          child: ListView(
            children: [
              SizedBox(height: 150),
              Text(
                'Welcome',
                textAlign: TextAlign.center,
                style: TextStyles.header,
              ),
              SizedBox(height: 20),
              Text(
                'Sign in or register yourself in order to continue',
                textAlign: TextAlign.center,
                style: TextStyles.subHeader,
              ),
              SizedBox(height: 100),
              CustomButton(
                title: 'Sign In',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignInScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              CustomButton(
                title: 'Sign Up',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
