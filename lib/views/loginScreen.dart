import 'dart:convert';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/controllers/authcontroller.dart';
import 'package:todoapp/views/signupScreen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

bool authswitch = false;
TextEditingController usernamecontroller = new TextEditingController();
TextEditingController passwordcontroller = new TextEditingController();

class _LoginPageState extends State<LoginPage> {
  final authcontroller = Get.find<Authcontroller>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              padding: EdgeInsets.only(top: 50),
              height: double.infinity,
              color: Colors.greenAccent,
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/todolist.png',
                  height: 120,
                  width: 120,
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              child: Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(85, 23, 0, 15),
                    child: Text(
                      "Log into Your Account",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  width: double.infinity,
                  height: 600,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)))),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Image.asset(
                              'assets/fb.jpeg',
                              height: 40,
                              width: 40,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            child: Image.asset(
                              'assets/tw.jpeg',
                              height: 40,
                              width: 40,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            child: Image.asset(
                              'assets/gplus.jpeg',
                              height: 40,
                              width: 40,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'or use your email account',
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 300,
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
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 300,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Switch(
                            value: authswitch,
                            onChanged: (value) => setState(() {
                              authswitch = value;
                            }),
                            activeColor: Colors.green,
                            inactiveTrackColor: Colors.yellow,
                            hoverColor: Colors.blue,
                          ),
                          // SizedBox(
                          //   width: 100,
                          // ),
                          Text(
                            'forget password?',
                            style: TextStyle(color: Colors.green),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            authcontroller.signin(
                                username: usernamecontroller.text,
                                password: passwordcontroller.text);
                          },
                          child: Text('Login'),
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(250, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ))),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('don\'t have an account?'),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(SignupScreen());
                            },
                            child: Text(
                              'Regsister Here',
                              style: TextStyle(color: Colors.green),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  width: double.infinity,
                  height: 530,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)))),
            ),
          ],
        ),
      ),
    );
  }
}
