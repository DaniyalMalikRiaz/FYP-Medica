/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Database {
   FirebaseFirestore firestore;
  initiliase() {
    firestore = FirebaseFirestore.instance;
  }


  Future<List> read() async {
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot = await firestore.collection('docotrs').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map a = {"id": doc.id, "age": doc['age'], "name": doc["name"], "qualification": doc["qualification"], "specialization": doc["specialization"]};
          docs.add(a);
        }
        return docs;
      }
    } catch (e) {
      print(e);
      
    }
  }
  
}
*/
