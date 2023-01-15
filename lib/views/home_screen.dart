import 'package:fish_detector/controller/auth_controller.dart';
import 'package:fish_detector/utils/text_styles.dart';
import 'package:fish_detector/views/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthController _authController = Get.put(AuthController());

  @override
  void initState() {
    _authController.extractInitialCharacter();
    _authController.getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                        backgroundColor: Colors.cyan,
                        child: Text(
                          _authController.initialCharacter.value.toUpperCase(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text.rich(
                      TextSpan(
                        text: 'Hello ',
                        style: TextStyles.cyanTitle,
                        children: [
                          TextSpan(
                            text: _authController.userTitle.value,
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                  const Center(
                    child: Icon(
                      Icons.search,
                      color: Colors.cyan,
                      size: 300,
                    ),
                  ),
                  const Text(
                    'Please Perform The Following Steps:',
                    style: TextStyles.boldDescription,
                  ),
                  const SizedBox(height: 10),
                  Text(
                      style: TextStyles.descriptionContent,
                      ''' 1. First, create a button or icon in your app's user interface that will allow the user to select an image from their device's camera or gallery.'''),
                  const SizedBox(height: 10),
                  Text(
                      style: TextStyles.descriptionContent,
                      ''' 2. When the user clicks the button, prompt them to choose whether they want to select an image from their camera or from their gallery.'''),
                  const SizedBox(height: 10),
                  Text(
                      style: TextStyles.descriptionContent,
                      ''' 3. If the user chooses to select an image from their camera, use the device's camera API to open the camera and allow the user to take a picture. Once the picture is taken, save it to the device's storage and pass it to the image detection algorithm.'''),
                  const SizedBox(height: 10),
                  Text(
                      style: TextStyles.descriptionContent,
                      ''' 4. If the user chooses to select an image from their gallery, use the device's file system API to access the user's gallery and allow them to select an image. Once the image is selected, pass it to the image detection algorithm.'''),
                  const SizedBox(height: 10),
                  Text(
                      style: TextStyles.descriptionContent,
                      ''' 5. The image detection algorithm should then process the image and determine if it contains a fish. This can be done using machine learning techniques such as convolutional neural networks.'''),
                  const SizedBox(height: 10),
                  Text(
                      style: TextStyles.descriptionContent,
                      ''' 6. If a fish is detected in the image, display a message or graphic indicating that a fish has been detected. If no fish is detected, display a message or graphic indicating that no fish was found in the image.'''),
                  const SizedBox(height: 10),
                  Text(
                      style: TextStyles.descriptionContent,
                      ''' 7. Repeat steps 1-6 as necessary to allow the user to select and analyze multiple images.'''),
                  const SizedBox(height: 40),
                  const Text(
                      style: TextStyles.subHeader,
                      ''' Note: This is a high level guide, there are various other factors you need to consider while creating such an app. like error handling, input validation, security etc.'''),
                  const SizedBox(height: 100),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
