import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:todoapp/constants/binding.dart';
import 'package:todoapp/views/NewTaskScreen.dart';
import 'package:todoapp/views/TaskEditScreen.dart';
import 'package:todoapp/views/loginScreen.dart';
import 'package:todoapp/views/signupScreen.dart';
import 'package:todoapp/views/taskcategoryScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        initialBinding: Todobinding(),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SignupScreen());
  }
}
