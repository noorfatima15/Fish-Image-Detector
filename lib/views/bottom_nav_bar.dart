import 'dart:io';
import 'package:fish_detector/controller/data_controller.dart';
import 'package:fish_detector/controller/navigation_controller.dart';
import 'package:fish_detector/views/about_screen.dart';
import 'package:fish_detector/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:get/get.dart';
import '../widgets/navigation_tab.dart';
import 'home_screen.dart';
import 'package:image_picker/image_picker.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<Widget> screens = [const HomeScreen(), const AboutScreen()];
  final ImageDataController imageDataController = Get.put(ImageDataController());
  final NavigationController _navigationController = Get.put(NavigationController());
  bool isLoading = true;
  final ImagePicker _picker = ImagePicker();
  File? _image;
  var _output;
  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  Future loadModel() async {
    await Tflite.loadModel(
        model: 'assets/vww_96_grayscale_quantized.tflite',
        labels: 'assets/labels.txt',
        numThreads: 1, // defaults to 1
        isAsset: true, // defaults to true, set to false to load resources outside assets
        useGpuDelegate: false //
        );
  }

  classifyImage(File image) {
    var output = Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 2, // defaults to 5
        threshold: 0.2, // defaults to 0.1
        asynch: true);
    setState(() {
      isLoading = false;
      _output = output;
      imageDataController.pickedImageFile.value = _output;
    });
  }

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
                                            //   final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
                                            //   File image = File(photo!.path);
                                            //   if (image == null) return null;
                                            //   setState(() {
                                            //     isLoading = true;
                                            //     _image = image;
                                            //     imageDataController.pickedImage = _image;
                                            //   });
                                            //   classifyImage(_image!);
                                            // })
                                            imageDataController.pickImageFromGallery();
                                          }),
                                      CustomButton(
                                          title: 'Pick Up From Gallery',
                                          onPressed: () async {
                                            final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
                                            File image = File(photo!.path);
                                            if (image == null) return null;
                                            setState(() {
                                              isLoading = true;
                                              _image = image;
                                              imageDataController.pickedImage = _image;
                                              imageDataController.pickedImageFile.value.first = _output;
                                            });
                                            classifyImage(_image!);
                                            print('Image Picked ${image.path}');
                                            print('output $_output');
                                            // Get.to(HomeScreen());
                                            Navigator.of(context).pop();
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
