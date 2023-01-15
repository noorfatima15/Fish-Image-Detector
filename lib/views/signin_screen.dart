import 'dart:async';

import 'package:fish_detector/controller/auth_controller.dart';
import 'package:fish_detector/utils/text_styles.dart';
import 'package:fish_detector/views/bottom_nav_bar.dart';
import 'package:fish_detector/views/home_screen.dart';
import 'package:fish_detector/widgets/custom_button.dart';
import 'package:fish_detector/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../constants/firebase_constants.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);
  final StreamController<bool> _passVisibility = StreamController<bool>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthController _authController = Get.put(AuthController());
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 150),
              const Text(
                'Sign In',
                textAlign: TextAlign.center,
                style: TextStyles.header,
              ),
              CustomTextField(
                hintText: 'Enter your email',
                keyboardType: TextInputType.emailAddress,
                isPrefixIconVisible: true,
                prefixIcon: Icons.email,
                controller: _emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  if (!value.contains('.')) {
                    return 'Please enter a valid email';
                  }
                  if (value.contains(' ')) {
                    return 'Please enter a valid email';
                  }
                  if (value.contains('#')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              StreamBuilder<bool>(
                  stream: _passVisibility.stream,
                  initialData: true,
                  builder: (context, snapshot) {
                    return CustomTextField(
                      hintText: 'Enter your password',
                      keyboardType: TextInputType.visiblePassword,
                      isPrefixIconVisible: true,
                      prefixIcon: Icons.lock,
                      controller: _passwordController,
                      isSuffixIconVisible: true,
                      suffixIcon: snapshot.data! ? Icons.visibility : Icons.visibility_off,
                      obscureText: snapshot.data!,
                      onSuffixIconTap: () {
                        _passVisibility.sink.add(!snapshot.data!);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    );
                  }),
              CustomButton(
                  title: 'Sign In',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _authController.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
                      Get.offAll(BottomNavBar());
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
