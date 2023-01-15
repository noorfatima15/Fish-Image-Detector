import 'dart:async';

import 'package:fish_detector/controller/auth_controller.dart';
import 'package:fish_detector/utils/text_styles.dart';
import 'package:fish_detector/views/bottom_nav_bar.dart';
import 'package:fish_detector/views/signin_screen.dart';
import 'package:fish_detector/widgets/custom_button.dart';
import 'package:fish_detector/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final StreamController<bool> _passVisibility = StreamController<bool>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _userName = TextEditingController();
  final AuthController _authController = Get.put(AuthController());
  void saveData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    _authController.saveUserData(sp.getString('userName').toString(), sp.getString('userEmail').toString(), sp.getString('userPassword').toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 80),
              const Text(
                'Sign Up',
                textAlign: TextAlign.center,
                style: TextStyles.header,
              ),
              CustomTextField(
                hintText: 'Enter your Name',
                keyboardType: TextInputType.name,
                isPrefixIconVisible: true,
                prefixIcon: Icons.person,
                controller: _userName,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
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
                        if (value.contains(' ')) {
                          return 'Password must not contain spaces';
                        }
                        if (!value.contains(RegExp(r'[A-Z]'))) {
                          return 'Password must contain at least one uppercase letter';
                        }
                        if (!value.contains(RegExp(r'[a-z]'))) {
                          return 'Password must contain at least one lowercase letter';
                        }
                        if (!value.contains(RegExp(r'[0-9]'))) {
                          return 'Password must contain at least one number';
                        }
                        if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                          return 'Password must contain at least one special character';
                        }
                        return null;
                      },
                    );
                  }),
              CustomButton(
                title: 'Sign Up',
                onPressed: () async {
                  //implement sign up logic
                  SharedPreferences sp = await SharedPreferences.getInstance();

                  if (_formKey.currentState!.validate()) {
                    if (_authController.userEmail.value != _emailController.text) {
                      _authController.createUserWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      Get.offAll(BottomNavBar());
                    } else {
                      const SnackBar(
                        content: Text('Email is Already exist'),
                      );
                    }
                    _authController.saveUid();
                    _authController.extractInitialCharacter();
                    sp.setString('userName', _userName.text);
                    sp.setString('userEmail', _emailController.text);
                    sp.setString('userPassword', _passwordController.text);
                    _authController.saveUserData(
                        sp.getString('userName').toString(), sp.getString('userEmail').toString(), sp.getString('userPassword').toString());
                    Get.offAll(BottomNavBar());
                  }
                },
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: const Divider(
                  color: Colors.grey,
                  thickness: 1,
                  height: 20,
                ),
              ),
              const Text(
                'Already have an Account?',
                textAlign: TextAlign.center,
                style: TextStyles.subHeader,
              ),
              const SizedBox(height: 150),
              CustomButton(
                  title: 'Sign In',
                  onPressed: () {
                    Get.to(const SignInScreen());
                  })
            ],
          ),
        ),
      ),
    );
  }
}
