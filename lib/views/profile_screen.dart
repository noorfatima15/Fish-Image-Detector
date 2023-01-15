import 'package:fish_detector/controller/auth_controller.dart';
import 'package:fish_detector/utils/text_styles.dart';
import 'package:fish_detector/views/bottom_nav_bar.dart';
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
                backgroundColor: Colors.cyan,
                child: Text(
                  authController.initialCharacter.value.toUpperCase(),
                  style: TextStyles.profileCharacter,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(authController.userTitle.value, textAlign: TextAlign.center, style: TextStyles.userName),
            const SizedBox(height: 200),
            Text(
              'In Order to logout just hit the button below',
              textAlign: TextAlign.center,
              style: TextStyles.descriptionContent,
            ),
            CustomButton(
              title: 'Log out',
              onPressed: () {
                authController.signOut();
                Get.offAll(const WelcomeScreen());
              },
            ),
            CustomButton(
              title: 'Go Back',
              onPressed: () {
                Get.offAll(BottomNavBar());
              },
            ),
          ],
        ),
      ),
    );
  }
}
