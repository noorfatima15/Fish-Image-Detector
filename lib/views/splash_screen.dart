import 'package:fish_detector/views/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/text_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () {
      Get.to(() => const WelcomeScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey.shade900,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Fish Detector', style: TextStyles.cyanTitle),
              Icon(Icons.search_outlined, size: 100, color: Colors.cyan),
              SizedBox(height: 80),
              CircularProgressIndicator(
                color: Colors.cyan,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
