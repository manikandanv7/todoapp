import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:todoapp/constants/httpconstants.dart';
import 'package:todoapp/controllers/newTaskcontroller.dart';
import 'package:todoapp/controllers/taskcontroller.dart';
import 'package:todoapp/views/NewTaskScreen.dart';
import 'package:todoapp/views/TaskEditScreen.dart';

class TaskList extends StatefulWidget {
  TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final taskcontroller = Get.find<Taskcontroller>();
  final newtaskcontroller = Get.find<NewTaskController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconTheme.of(context).copyWith(color: Colors.black),
        elevation: 0,
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: TextButton(
          child: Text('Logout'),
          onPressed: (() {
            auth.signOut();
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(() => NewTask());
        },
      ),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            itemCount: taskcontroller.categorylist.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.to(() => TaskEdit(categoryIndex: index));
                },
                child: Card(
                  elevation: 5,
                  shadowColor: Colors.grey,
                  color: Colors.white,
                  child: Container(
                      margin: EdgeInsets.all(3),
                      padding: EdgeInsets.all(13),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: Icon(
                                  taskcontroller.categorylist[index].icon)),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            taskcontroller.categorylist[index].title.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Obx(() => Text(
                              taskcontroller.categorylist[index].title
                                          .toString() ==
                                      'All'
                                  ? newtaskcontroller.tasks.length.toString()
                                  : newtaskcontroller.tasks
                                      .where((element) =>
                                          element.category ==
                                          taskcontroller
                                              .categorylist[index].title
                                              .toString())
                                      .length
                                      .toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Colors.grey))),
                        ],
                      )),
                ),
              );
            },
          )),
    );
  }
}
