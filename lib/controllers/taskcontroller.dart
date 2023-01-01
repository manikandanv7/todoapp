import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/models/category.dart';

class Taskcontroller extends GetxController {
  var categorylist = <Category>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    addcategory();
    super.onInit();
  }

  void addcategory() {
    categorylist.add(Category(Icons.all_inbox, "All", 0, []));
    categorylist.add(Category(Icons.work_rounded, "Work", 0, []));
    categorylist.add(Category(Icons.travel_explore_outlined, "Travel", 0, []));
    categorylist.add(Category(Icons.shop, "Shopping", 0, []));
    categorylist
        .add(Category(Icons.cast_for_education_outlined, "Study", 0, []));
    categorylist.add(Category(Icons.home, "Home", 0, []));
  }
}
