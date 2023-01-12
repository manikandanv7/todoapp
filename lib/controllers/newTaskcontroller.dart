import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/constants/httpconstants.dart';
import 'package:todoapp/controllers/authcontroller.dart';
import 'package:todoapp/controllers/taskcontroller.dart';
import 'package:todoapp/models/category.dart';
import 'package:todoapp/models/category.dart';
import 'package:todoapp/models/task.dart';
import 'package:todoapp/models/users.dart';
import 'package:todoapp/views/TaskEditScreen.dart';
import 'package:todoapp/views/loginScreen.dart';
import 'package:todoapp/views/taskcategoryScreen.dart';
import 'package:todoapp/constants/httpconstants.dart';

class NewTaskController extends GetxController {
  final taskcontroller = Get.find<Taskcontroller>();

  final _newtasklist = <AddNewTask>[].obs;
  List<AddNewTask> get tasks => _newtasklist.value;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _newtasklist.bindStream(store
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('tasks')
        .snapshots()
        .map((QuerySnapshot query) {
      List<AddNewTask> retvalue = [];
      for (var element in query.docs) {
        retvalue.add(AddNewTask.fromsnap(element));
      }
      return retvalue;
    }));
  }

  void saveTask({
    String? desc,
    DateTime? date,
    String? note,
    String? category,
  }) async {
    // for (int i = 0; i < taskcontroller.categorylist.length; i++) {
    //   if (taskcontroller.categorylist[i].title == category) {
    //     //     print("${taskcontroller.categorylist[i].title}+$i");
    //     taskcontroller.categorylist[i].addnewtask!.add(AddNewTask(
    //         Desc: desc, category: category, taskdate: date, note: note));
    //   }
    // }
    Get.snackbar(
      "New Task Created successfully",
      "",
      duration: Duration(
        seconds: 1,
      ),
    );
    Get.to(() => TaskList());
    _newtasklist.add(
        AddNewTask(Desc: desc, category: category, note: note, taskdate: date));
    var document = await store
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('tasks')
        .get();

    int len = document.docs.length + 1;
    AddNewTask task1 =
        AddNewTask(Desc: desc, category: category, note: note, taskdate: date);

    // DocumentSnapshot userdocument=await store.collection('users').doc(auth.currentUser!.uid).get();
    // int len=userdocument.docs.length;
    await store
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('tasks')
        .doc(len.toString())
        .set(task1.toJson());
  }

  void deletetask(String notes) async {
    CollectionReference document = await store
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('tasks');
    var snapshots = await document.where('note', isEqualTo: notes).get();
    for (var doc in snapshots.docs) {
      doc.reference.delete();
    }
  }

  getalltasks() async {
    _newtasklist.bindStream(store
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('tasks')
        .snapshots()
        .map((QuerySnapshot query) {
      List<AddNewTask> retvalue = [];
      for (var element in query.docs) {
        retvalue.add(AddNewTask.fromsnap(element));
      }
      return retvalue;
    }));
  }

  void updateTask(
      String desc, DateTime selecteddate, String note, String category) async {
    CollectionReference document = await store
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('tasks');
    var snapshots = await document.where('note', isEqualTo: note).get();
    for (var doc in snapshots.docs) {
      doc.reference.update({
        'Desc': desc,
        'category': category,
        'note': note,
        'taskdate': selecteddate
      });
    }
    //  await store.collection('users').doc(auth.currentUser!.uid).collection('tasks').doc(category).collection(note).doc('${auth.currentUser!.uid}.${selecteddate}')
    Get.to(() => TaskList());
  }
}
