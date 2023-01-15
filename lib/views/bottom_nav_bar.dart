import 'package:fish_detector/controller/data_controller.dart';
import 'package:fish_detector/controller/navigation_controller.dart';
import 'package:fish_detector/views/about_screen.dart';
import 'package:fish_detector/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/navigation_tab.dart';
import 'home_screen.dart';
import 'package:image_picker/image_picker.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({Key? key}) : super(key: key);
  List<Widget> screens = [const HomeScreen(), const AboutScreen()];
  final NavigationController _navigationController = Get.put(NavigationController());
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
        body: SafeArea(
      child: Obx(
        () => Stack(
          children: [
            screens[_navigationController.currentIndex.value],
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 60,
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  NavigationTab(
                    tabTitle: 'Home',
                    tabIcon: Icons.home,
                    onTap: () {
                      _navigationController.currentIndex.value = 0;
                      screens[_navigationController.currentIndex.value];
                      if (_navigationController.currentIndex.value == 0) {
                        _navigationController.isTabSelected.value = true;
                      }
                    },
                    selectedColor: _navigationController.currentIndex.value == 0 ? Colors.cyan : Colors.white,
                  ),
                  NavigationTab(
                    tabTitle: 'About',
                    tabIcon: Icons.info,
                    onTap: () {
                      _navigationController.currentIndex.value = 1;
                      screens[_navigationController.currentIndex.value];
                      if (_navigationController.currentIndex.value == 1) {
                        _navigationController.isTabSelected.value = true;
                      }
                    },
                    selectedColor: _navigationController.currentIndex.value == 1 ? Colors.cyan : Colors.white,
                  ),
                ]),
              ),
            ),
            Positioned.fill(
                bottom: 40,
                top: mediaQuery.size.height * 0.85,
                child: Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Image Detection'),
                            content: Text('Please Choose Any one of the following category'),
                            actions: <Widget>[
                              Center(
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 180,
                                  child: Column(
                                    children: [
                                      CustomButton(
                                          title: 'Camera',
                                          onPressed: () async {
                                            final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
                                          }),
                                      CustomButton(
                                          title: 'Pick Up From Gallery',
                                          onPressed: () async {
                                            final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
                                          }),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 70,
                      width: 70,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.cyan,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    ));
  }
}
