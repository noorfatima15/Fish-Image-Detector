import 'package:fish_detector/controller/auth_controller.dart';
import 'package:fish_detector/utils/text_styles.dart';
import 'package:fish_detector/views/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../widgets/custom_button.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
            SizedBox(height: 20),
            Text(
              'My Account',
              style: TextStyles.header,
            ),
            SizedBox(height: 40),
            Center(
              child: CircleAvatar(
                radius: 100,
                child: Text(authController.initialCharacter.value),
              ),
            ),
            SizedBox(height: 80),
            CustomButton(
              title: 'Log out',
              onPressed: () {
                authController.signOut();
                Get.offAll(WelcomeScreen());
              },
            )
          ],
        ),
      ),
    );
  }
}
