import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:todoapp/controllers/newTaskcontroller.dart';
import 'package:todoapp/controllers/taskcontroller.dart';
import 'package:todoapp/models/task.dart';
import 'package:todoapp/views/NewTaskScreen.dart';

class TaskEdit extends StatefulWidget {
  const TaskEdit({super.key, required this.categoryIndex});
  final int categoryIndex;

  @override
  State<TaskEdit> createState() => _TaskEditState();
}

void navigatetoNewTaskScreen({
  required String category,
  required String desc,
  required String note,
  required DateTime taskdate,
  required String action,
}) {
  Get.to(() => NewTask(
        Category: category,
        description: desc,
        note: note,
        taskdate: taskdate,
        action: 'Modify',
      ));
}

class _TaskEditState extends State<TaskEdit> {
  final taskcontroller = Get.find<NewTaskController>();
  final taskcontroller2 = Get.find<Taskcontroller>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(() => NewTask(),
              duration: Duration(seconds: 1), transition: Transition.downToUp);
        },
      ),
      body: Stack(alignment: Alignment.bottomCenter, children: [
        Container(
          color: Colors.lightBlue,
        ),
        Container(
          child: Positioned(
            bottom: 600,
            left: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  child: Icon(
                    taskcontroller2.categorylist[widget.categoryIndex].icon,
                    color: Colors.blue,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  taskcontroller2.categorylist[widget.categoryIndex].title
                      .toString(),
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                    taskcontroller.tasks
                        .where((element) =>
                            element.category ==
                            taskcontroller2
                                .categorylist[widget.categoryIndex + 1].title)
                        .length
                        .toString(),
                    style: TextStyle(color: Colors.white, fontSize: 18))
              ],
            ),
          ),
        ),
        Positioned(
          child: Container(
            height: 520,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20))),
            child: Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: ListView.builder(
                    itemCount: 1,
                    shrinkWrap: true,
                    itemBuilder: ((context, index) {
                      // print(
                      //     "${taskcontroller2.categorylist[widget.categoryIndex].addnewtask!.where((p0) => p0.taskdate!.day < DateTime.now().day).length}ffffffff");
                      return Column(
                        children: [
                          Text('Late'),
                          Obx((() => ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: taskcontroller.tasks
                                  .where((p0) =>
                                      p0.taskdate!.day < DateTime.now().day &&
                                      p0.category ==
                                          taskcontroller2
                                              .categorylist[
                                                  widget.categoryIndex]
                                              .title)
                                  .length,
                              itemBuilder: (context, index1) {
                                List list1 = [];
                                List<int> list1Index = [];
                                for (int i = 0;
                                    i < taskcontroller.tasks.length;
                                    i++) {
                                  if (taskcontroller.tasks[i].taskdate!.day <
                                          DateTime.now().day &&
                                      taskcontroller.tasks[i].category ==
                                          taskcontroller2
                                              .categorylist[
                                                  widget.categoryIndex]
                                              .title) {
                                    list1.add(taskcontroller.tasks[i]);
                                    // list2Index.add(i);
                                  }
                                }

                                //print(list2[index2].note.toString());
                                return ListTile(
                                    trailing: PopupMenuButton(
                                      initialValue: 1,
                                      child: Icon(Icons.more_vert),
                                      onSelected: (value) {
                                        switch (value) {
                                          case 1:
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: ((context) {
                                              return NewTask(
                                                Category:
                                                    list1[index1].category,
                                                description: list1[index1].Desc,
                                                note: list1[index1].note,
                                                taskdate:
                                                    list1[index1].taskdate,
                                                action: 'Modify',
                                              );
                                            })));
                                            break;
                                          case 2:
                                            taskcontroller.deletetask(
                                                list1[index1].note.toString());
                                            break;
                                        }
                                      },
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          value: 2,
                                          child: Text("Delete"),
                                        ),
                                        PopupMenuItem(
                                          child: Text("Modify"),
                                          value: 1,
                                        ),
                                      ],
                                    ),
                                    title: Text(list1[index1].note.toString()),
                                    subtitle: Text(
                                        list1[index1].taskdate.toString()));
                              }))),
                          Text('Today'),
                          Obx((() => ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: taskcontroller.tasks
                                  .where((p0) =>
                                      p0.taskdate!.day == DateTime.now().day &&
                                      p0.category ==
                                          taskcontroller2
                                              .categorylist[
                                                  widget.categoryIndex]
                                              .title)
                                  .length,
                              itemBuilder: (context, index2) {
                                List list2 = [];
                                List<int> list2Index = [];
                                for (int i = 0;
                                    i < taskcontroller.tasks.length;
                                    i++) {
                                  if (taskcontroller.tasks[i].taskdate!.day ==
                                          DateTime.now().day &&
                                      taskcontroller.tasks[i].category ==
                                          taskcontroller2
                                              .categorylist[
                                                  widget.categoryIndex]
                                              .title) {
                                    list2.add(taskcontroller.tasks[i]);
                                    // list2Index.add(i);
                                  }
                                }

                                //print(list2[index2].note.toString());
                                return ListTile(
                                    trailing: PopupMenuButton(
                                      initialValue: 1,
                                      child: Icon(Icons.more_vert),
                                      onSelected: (value) {
                                        switch (value) {
                                          case 1:
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: ((context) {
                                              return NewTask(
                                                Category:
                                                    list2[index2].category,
                                                description: list2[index2].Desc,
                                                note: list2[index2].note,
                                                taskdate:
                                                    list2[index2].taskdate,
                                                action: 'Modify',
                                              );
                                            })));
                                            break;
                                          case 2:
                                            taskcontroller.deletetask(
                                                list2[index2].note.toString());
                                            break;
                                        }
                                      },
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          value: 2,
                                          child: Text("Delete"),
                                        ),
                                        PopupMenuItem(
                                          child: Text("Modify"),
                                          value: 1,
                                        ),
                                      ],
                                    ),
                                    title: Text(list2[index2].note.toString()),
                                    subtitle: Text(
                                        list2[index2].taskdate.toString()));
                              }))),
                          Text("Done"),
                          Obx((() => ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: taskcontroller.tasks
                                  .where((p0) =>
                                      p0.taskdate!.day > DateTime.now().day &&
                                      p0.category ==
                                          taskcontroller2
                                              .categorylist[
                                                  widget.categoryIndex]
                                              .title)
                                  .length,
                              itemBuilder: (context, index3) {
                                List list3 = [];
                                List<int> list3Index = [];
                                for (int i = 0;
                                    i < taskcontroller.tasks.length;
                                    i++) {
                                  if (taskcontroller.tasks[i].taskdate!.day >
                                          DateTime.now().day &&
                                      taskcontroller.tasks[i].category ==
                                          taskcontroller2
                                              .categorylist[
                                                  widget.categoryIndex]
                                              .title) {
                                    list3.add(taskcontroller.tasks[i]);
                                    // list2Index.add(i);
                                  }
                                }

                                //print(list2[index2].note.toString());
                                return ListTile(
                                    trailing: PopupMenuButton(
                                      initialValue: 1,
                                      child: Icon(Icons.more_vert),
                                      onSelected: (value) {
                                        switch (value) {
                                          case 1:
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: ((context) {
                                              return NewTask(
                                                Category:
                                                    list3[index3].category,
                                                description: list3[index3].Desc,
                                                note: list3[index3].note,
                                                taskdate:
                                                    list3[index3].taskdate,
                                                action: 'Modify',
                                              );
                                            })));
                                            break;
                                          case 2:
                                            taskcontroller.deletetask(
                                                list3[index3].note.toString());
                                            break;
                                        }
                                      },
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          value: 2,
                                          child: Text("Delete"),
                                        ),
                                        PopupMenuItem(
                                          child: Text("Modify"),
                                          value: 1,
                                        ),
                                      ],
                                    ),
                                    title: Text(list3[index3].note.toString()),
                                    subtitle: Text(
                                        list3[index3].taskdate.toString()));
                              }))),
                        ],
                      );
                    }))),
          ),
        ),
      ]),
    );
  }
}
