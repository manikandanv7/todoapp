import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:todoapp/controllers/authcontroller.dart';
import 'package:todoapp/constants/httpconstants.dart';
import 'package:todoapp/constants/binding.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  TextEditingController usernamecontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authcontroller = Get.find<Authcontroller>();
    return Scaffold(
      appBar: AppBar(title: Text("Signup")),
      body: Column(children: [
        Container(
            width: double.infinity,
            child: TextFormField(
              controller: usernamecontroller,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.green)),
                focusedBorder: OutlineInputBorder(
                    //  borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.red)),
                hintText: 'UserName',
              ),
            )),
        SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          child: TextFormField(
            controller: passwordcontroller,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  //// borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.green)),
              focusedBorder: OutlineInputBorder(
                  // borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.red)),
              hintText: 'password',
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ElevatedButton(
            onPressed: (() {
              authcontroller.signup(
                  username: usernamecontroller.text,
                  password: passwordcontroller.text);
              usernamecontroller.dispose();
              passwordcontroller.dispose();
            }),
            child: Text("Signup"))
      ]),
    );
  }
}
