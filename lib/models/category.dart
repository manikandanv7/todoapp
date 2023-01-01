import 'package:flutter/material.dart';
import 'package:todoapp/models/task.dart';

class Category {
  IconData icon;
  String? title;
  int? Taskcount;
  List<AddNewTask>? addnewtask;
  Category(this.icon, this.title, this.Taskcount, this.addnewtask);
}
