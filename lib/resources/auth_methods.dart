import 'package:firebase_auth/firebase_auth.dart';
import "package:cloud_firestore/cloud_firestore.dart";

class AuthMethods {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //create new user
  Future<String> registerUser({
    required String name,
    required String email,
    required String phone,
    required String usertype,
    required String password,
  }) async {
    String response = "";
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = cred.user!;
      await _firestore.collection("users").doc(user.uid).set({
        "name": name,
        "email": email,
        "phone": phone,
        "usertype": usertype,
        "password": password,
        "uid": user.uid,
        "profile_image": "",
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
      UserCredential cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = cred.user!;
      response = "success";
    } catch (e) {
      response = e.toString();
    }

    return response;
  }
}
