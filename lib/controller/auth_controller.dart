import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/firebase_constants.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();
  static AuthController instance = AuthController();
  Rxn<User> _firebaseUser = Rxn<User>();
  User? get user => _firebaseUser.value;
  RxString email = ''.obs;
  RxString password = ''.obs;
  RxString userTitle = ''.obs;
  RxString initialCharacter = ''.obs;
  Future<void> saveUser(String userName, String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', userName);
    prefs.setString('userEmail', email);
    prefs.setString('userPassword', password);
    userTitle.value = userName;
  }

  void extractInitialCharacter() {
    var list = userTitle.split('');
    initialCharacter.value = list.first;
  }

  //function for save uid from firebase
  RxString uid = ''.obs;
  Future<void> saveUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('uid', auth.currentUser!.uid);
    uid.value = auth.currentUser!.uid;
  }

  @override
  void onInit() {
    _firebaseUser.bindStream(auth.authStateChanges());
    super.onInit();
  }

  void createUserWithEmailAndPassword({required String email, required String password}) async {
    // create user with email and password and store data to firebase
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        const SnackBar(
          content: Text('The password provided is too weak.'),
        );
      } else if (e.code == 'email-already-in-use') {
        SnackBar(content: Text('The account already exists for that email.'));
      }
    } catch (e) {
      print(e);
    }
  }

  void signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        const SnackBar(content: Text('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        const SnackBar(content: Text('Wrong password provided for that user.'));
      }
    }
  }

  void signOut() async {
    await auth.signOut();
  }

  void saveUserToFirebase() async {
    // save user data to firebase
  }
}
