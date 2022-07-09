import 'package:cloud_firestore/cloud_firestore.dart';

// import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

class Database {
  Map<String, dynamic> _myObj = {};
  var _db = FirebaseFirestore.instance;

  void add(Map<String, dynamic> obj) {
    _myObj = obj;

    // Check if the ID already exists
    // checkExistingDoc(_myObj);

    // Add a new document with a set ID
    _db.collection("test").doc(_myObj["category"]).set(_myObj);
    // _db.collection("test").
  }

  // DocumentReference<Map<String, dynamic>>
  Future<QuerySnapshot<Map<String, dynamic>>> read() async {
    Future<QuerySnapshot<Map<String, dynamic>>> result =
        _db.collection("test").get();

    result.then(
      (QuerySnapshot q) => {print("${q.docs}")},
      onError: (e) => print("Error completing: $e"),
    );
    return result;
  }

  Future checkExistingDoc(Map<String, dynamic> obj) async {
    _myObj = obj;

    var existingDoc =
        await _db.collection('test').doc(_myObj["category"]).get();
    if (existingDoc.exists) {
      print('Exists');
      final docRef = _db.collection('test').doc(_myObj["category"]);
      docRef.set({
        'name': _myObj["name"],
        'quantity': _myObj["quantity"],
        'size': _myObj["size"]
      }, SetOptions(merge: true));
      return existingDoc;
    }
    if (!existingDoc.exists) {
      print('Not exists');
      _db.collection("test").doc(_myObj["category"]).set(_myObj);
      return existingDoc;
    }
  }
}
