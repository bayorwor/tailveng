import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tailveng/resources/storage_methods.dart';

class StyleMethods {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String user = FirebaseAuth.instance.currentUser!.uid;

//add a style
  Future<String> addStyle(
      {required String styleName, required Uint8List styleImage}) async {
    String res = "";
    try {
      String picUrl = await StorageMethods()
          .uploadImageToStorage("styles", styleImage, true);
      await _firestore.collection('styles').add({
        'style_name': styleName,
        'style_image': picUrl,
        "uid": user,
      });
      return res = "success";
    } catch (e) {
      res = e.toString();
      return res;
    }
  }

  //get all styles
  Future<List<DocumentSnapshot>> getAllStyles() async {
    List<DocumentSnapshot> styles = [];
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('styles')
          .where("uid", isEqualTo: user)
          .get();
      styles = querySnapshot.docs;
      return styles;
    } catch (e) {
      print(e.toString());
      return styles;
    }
  }
}
