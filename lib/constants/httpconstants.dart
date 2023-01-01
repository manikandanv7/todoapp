import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var baseurl = 'https://reqres.in/api/login';
// final auth = FirebaseAuth.instanceFor(
//     app: Firebase.app(), persistence: Persistence.NONE);
final auth = FirebaseAuth.instance;
final store = FirebaseFirestore.instance;
