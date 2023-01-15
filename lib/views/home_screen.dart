import 'package:fish_detector/controller/auth_controller.dart';
import 'package:fish_detector/utils/text_styles.dart';
import 'package:fish_detector/views/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final AuthController _authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          children: [
            Center(
              child: Column(
                children: [
                  Row(children: [
                    GestureDetector(
                      onTap: () {
                        Get.offAll(ProfileScreen());
                      },
                      child: CircleAvatar(
                        child: Text(_authController.initialCharacter.value),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text.rich(
                      TextSpan(
                        text: 'Hello',
                        style: TextStyles.cyanTitle,
                        children: [
                          TextSpan(
                            text: _authController.userTitle.value,
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
