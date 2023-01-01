import 'package:cloud_firestore/cloud_firestore.dart';

class user {
  String email;
  String uid;
  user({required this.email, required this.uid});

  Map<String, dynamic> toJson() => {'email': email, 'uid': uid};

  static user fromsnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return user(email: snapshot['email'], uid: snapshot['uid']);
  }
}
