import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:todoapp/constants/httpconstants.dart';
import 'package:todoapp/controllers/newTaskcontroller.dart';
import 'package:todoapp/models/category.dart';
import 'package:todoapp/views/NewTaskScreen.dart';
import 'package:todoapp/views/loginScreen.dart';
import 'package:todoapp/models/users.dart' as model;
import '../views/taskcategoryScreen.dart';

class Authcontroller extends GetxController {
  static Authcontroller instance = Get.find();
  static NewTaskController instance2 = Get.find();
  late Rx<User?> _user;
  User get user => _user.value!;
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginPage());
    } else
      Get.offAll(() => TaskList());
  }

  void signin({required String username, required String password}) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: username, password: password);

      // print(credential.additionalUserInfo.toString() + "njjjjjjjjjjjjjjjj");
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error in Creating Account", e.code.toString());
    }
  }

  void signup({required String username, required String password}) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
          email: username, password: password);

      print(credential.additionalUserInfo);
      model.user user1 = model.user(email: username, uid: credential.user!.uid);
      await store
          .collection('users')
          .doc(credential.user!.uid)
          .set(user1.toJson());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    }
  }

  void signout() async {
    await auth.signOut();
  }
}
