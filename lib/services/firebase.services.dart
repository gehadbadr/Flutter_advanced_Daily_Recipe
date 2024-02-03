
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  //get user data
  static getUser(uid){
    return FirebaseFirestore.instance.collection('users').where('id',isEqualTo: uid).snapshots();
  }
}