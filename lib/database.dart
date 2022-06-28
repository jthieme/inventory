
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';



class Database {

  Map<String, dynamic> _myObj = {};
  var _db = FirebaseFirestore.instance;

  void add(Map<String, dynamic> obj){
    _myObj = obj;
    // Add a new document with a generated ID
    _db.collection("test").add(_myObj).then((DocumentReference doc) =>
        print('DocumentSnapshot added with ID: ${doc.id}'));
  }

  Map read() {
    return _myObj;
  }

}
