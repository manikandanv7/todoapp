import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:todoapp/controllers/newTaskcontroller.dart';
import 'package:todoapp/controllers/taskcontroller.dart';

class NewTask extends StatefulWidget {
  NewTask({
    super.key,
    this.Category,
    this.description,
    this.note,
    this.taskdate,
    this.action,
  });
  final String? description;
  final String? note;
  late String? Category;

  late DateTime? taskdate;
  late String? action;

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  DateTime selecteddate = DateTime.now();
  late int isCategorySelected;
  String defaultcategory = '';
  String action = 'Create';
  int? index;
  TextEditingController desccontroller = new TextEditingController();
  TextEditingController notecontroller = new TextEditingController();
  @override
  void initState() {
    if (widget.Category != null &&
        widget.description != null &&
        widget.note != null &&
        widget.taskdate != null) {
      desccontroller.text = widget.description!;
      defaultcategory = widget.Category!;
      selecteddate = widget.taskdate!;
      notecontroller.text = widget.note!;
      action = widget.action!;
      ;
    }

    super.initState();
  }

  void selectCategory(int value) {
    setState(() {
      isCategorySelected = value;
      // print(isCategorySelected);
      Get.back();
    });
  }

  void datepicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime(2025))
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        selecteddate = value;
        print('$selecteddate ..................');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskcontroller = Get.find<Taskcontroller>();
    final newtaskcontroller = Get.find<NewTaskController>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: (() {}),
              icon: Icon(
                Icons.cancel_outlined,
                color: Colors.black,
              ))
        ],
        title: Text(
          'NewTask',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextField(
            controller: desccontroller,
            decoration: InputDecoration(
                labelText: 'What you are planning?',
                alignLabelWithHint: true,
                labelStyle: TextStyle(color: Colors.grey, fontSize: 20)),
            maxLines: 8,
            style: TextStyle(),
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.notifications,
              ),
              SizedBox(
                width: 5,
              ),
              TextButton(
                  onPressed: datepicker,
                  child: Text(DateFormat().format(selecteddate).toString(),
                      style: TextStyle(color: Colors.black)))
            ],
          ),
          TextButton.icon(
              onPressed: (() {
                Get.defaultDialog(
                    title: "Select Category",
                    content: Column(
                      children: [
                        Container(
                          height: 250,
                          width: 150,
                          child: ListView.separated(
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 15,
                                  ),
                              itemCount: taskcontroller.categorylist.length,
                              itemBuilder: ((context, index) {
                                if (index > 0) {
                                  return Row(
                                    children: [
                                      Container(
                                        child: InkWell(
                                          splashColor: Colors.green,
                                          onTap: () {
                                            selectCategory(index);
                                          },
                                          child: Text(taskcontroller
                                              .categorylist[index].title
                                              .toString()),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  );
                                }
                                return SizedBox();
                              })),
                        ),
                      ],
                    ));
              }),
              icon: Icon(
                Icons.category,
                color: Colors.black,
              ),
              label: Text(
                "Category",
                style: TextStyle(color: Colors.black),
              )),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.sticky_note_2_rounded,
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                height: 50,
                width: 300,
                child: TextField(
                  controller: notecontroller,
                  decoration: InputDecoration(
                      focusColor: Colors.black,
                      labelText: 'Note',
                      alignLabelWithHint: true,
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 20)),
                ),
              ),
            ],
          ),
        ]),
      ),
      floatingActionButton: Container(
        width: double.infinity,
        child: ElevatedButton(
          child: Text(action),
          onPressed: () {
            if (action == 'Create') {
              if (desccontroller.text.isEmpty ||
                  selecteddate == null ||
                  notecontroller.text.isEmpty ||
                  taskcontroller
                      .categorylist[isCategorySelected].title!.isEmpty ||
                  taskcontroller.categorylist[isCategorySelected].title! ==
                      null) {
                Get.snackbar("Unable to create Task", "Give complete details");
              } else {
                print(selecteddate);
                newtaskcontroller.saveTask(
                    desc: desccontroller.text,
                    date: DateTime.parse(
                        DateFormat("yyyy-MM-dd").format(selecteddate)),
                    note: notecontroller.text,
                    category:
                        taskcontroller.categorylist[isCategorySelected].title);
                //  print(desccontroller.text + "textttttttttttttttttttttttttttttt");
                notecontroller.clear();
                desccontroller.clear();
              }
            } else {
              if (desccontroller.text.isEmpty ||
                  selecteddate == null ||
                  notecontroller.text.isEmpty ||
                  taskcontroller
                      .categorylist[isCategorySelected].title!.isEmpty) {
                Get.snackbar("Unable to create Task", "Give complete details");
              } else {
                newtaskcontroller.updateTask(
                    desccontroller.text,
                    selecteddate,
                    notecontroller.text,
                    taskcontroller.categorylist[isCategorySelected].title!);
                notecontroller.clear();
                desccontroller.clear();
              }
            }
          },
        ),
      ),
    );
  }
}
