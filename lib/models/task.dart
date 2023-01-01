import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AddNewTask {
  String? Desc;
  DateTime? taskdate;
  String? note;
  String? category;

  AddNewTask({this.Desc, this.category, this.note, this.taskdate});
  Map<String, dynamic> toJson() => {
        'Desc': Desc,
        'taskdate': DateTime.parse(DateFormat("yyyy-MM-dd").format(taskdate!)),
        'note': note,
        'category': category,
      };
  static AddNewTask fromsnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return AddNewTask(
        Desc: snapshot['Desc'],
        taskdate: snapshot['taskdate'].toDate(),
        note: snapshot['note'],
        category: snapshot['category']);
  }
}
