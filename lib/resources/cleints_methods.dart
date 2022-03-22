import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tailveng/resources/storage_methods.dart';

class ClientMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//add user details to firestore
  Future<String> addClient(
      {required String name,
      required String phone,
      required String gender,
      required String style,
      required String waist,
      required String breast,
      required String hips,
      required String length,
      required String height,
      required String location,
      required Uint8List image}) async {
    String response = "";
    try {
      String picUrl =
          await StorageMethods().uploadImageToStorage("materials", image, true);

      String userId = _auth.currentUser!.uid;

      await _firestore.collection('clients').doc().set({
        'name': name,
        'phone': phone,
        'gender': gender,
        "style": style,
        "waist": waist,
        "breast": breast,
        "hips": hips,
        "length": length,
        "height": height,
        "location": location,
        "uid": userId,
        "completed": false,
        "image": picUrl,
      });
      response = "success";
    } catch (error) {
      response = error.toString();
    }
    return response;
  }

  //get all clients
  Stream<QuerySnapshot<Map<String, dynamic>?>> getClients() {
    String userId = _auth.currentUser!.uid;

    return _firestore
        .collection('clients')
        .where("uid", isEqualTo: userId)
        .snapshots();
  }

//get materials that are completed
  Stream<QuerySnapshot<Map<String, dynamic>?>> getCompletedMaterials() {
    String userId = _auth.currentUser!.uid;

    return _firestore
        .collection('clients')
        .where('completed', isEqualTo: true)
        .where('uid', isEqualTo: userId)
        .snapshots();
  }

//get materials that are completed
  Stream<QuerySnapshot<Map<String, dynamic>?>> getNotCompleted() {
    String userId = _auth.currentUser!.uid;

    return _firestore
        .collection('clients')
        .where('completed', isEqualTo: false)
        .where('uid', isEqualTo: userId)
        .snapshots();
  }

  //update client details
  updateToDone(String id) {
    String response = "";
    try {
      _firestore.collection('clients').doc(id).update({
        'completed': true,
      });
      response = "success";
    } catch (error) {
      response = error.toString();
    }
    return response;
  }

  //update client details
  deleteOne(String id) {
    String response = "";
    try {
      _firestore.collection('clients').doc(id).delete();
      response = "success";
    } catch (error) {
      response = error.toString();
    }
    return response;
  }
}
