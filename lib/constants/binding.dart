import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:todoapp/controllers/authcontroller.dart';
import 'package:todoapp/controllers/taskcontroller.dart';
import 'package:todoapp/controllers/newTaskcontroller.dart';
import 'package:todoapp/views/TaskEditScreen.dart';

class Todobinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Taskcontroller(), fenix: true);
    Get.lazyPut(() => NewTaskController(), fenix: true);
    Get.lazyPut(() => Authcontroller(), fenix: true);
  }
}
