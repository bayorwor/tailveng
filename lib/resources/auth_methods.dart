import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:tailveng/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //create new user
  Future<String> registerUser({
    required String name,
    required String email,
    required String phone,
    required String usertype,
    required String password,
    required Uint8List profilePic,
  }) async {
    String response = "";
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      String picUrl = await StorageMethods()
          .uploadImageToStorage("profiles", profilePic, false);

      User user = cred.user!;
      await _firestore.collection("users").doc(user.uid).set({
        "name": name,
        "email": email,
        "phone": phone,
        "usertype": usertype,
        "password": password,
        "uid": user.uid,
        "profile_image": picUrl,
      });
      response = "success";
    } catch (e) {
      response = e.toString();
    }

    return response;
  }

  //login user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String response = "";
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      response = "success";
    } catch (e) {
      response = e.toString();
    }

    return response;
  }

  //forgot password
  Future<String> forgotPassword({
    required String email,
  }) async {
    String response = "";
    try {
      await _auth.sendPasswordResetEmail(email: email);
      response = "success";
    } catch (e) {
      response = e.toString();
    }

    return response;
  }

  //get user details
  Future<Map<String, dynamic>?> getUserDetails() async {
    String uid = _auth.currentUser!.uid;
    DocumentSnapshot<Map<String, dynamic>> user =
        await _firestore.collection("users").doc(uid).get();
    return user.data()!.map((key, value) => MapEntry(key, value));
  }
}
