import 'package:fish_detector/controller/auth_controller.dart';
import 'package:fish_detector/utils/text_styles.dart';
import 'package:fish_detector/views/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/custom_button.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'My Account',
                style: TextStyles.header,
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: CircleAvatar(
                radius: 100,
                child: Text(
                  authController.initialCharacter.value,
                  style: TextStyles.profileCharacter,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(authController.userTitle.value, textAlign: TextAlign.center, style: TextStyles.subHeader),
            const SizedBox(height: 300),
            Text(
              'In Order to logout just hit the button below',
              textAlign: TextAlign.center,
              style: TextStyles.aboutDescriptionText,
            ),
            CustomButton(
              title: 'Log out',
              onPressed: () {
                authController.signOut();
                Get.offAll(const WelcomeScreen());
              },
            )
          ],
        ),
      ),
    );
  }
}
