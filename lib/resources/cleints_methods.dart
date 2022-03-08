import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ClientMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User user = FirebaseAuth.instance.currentUser!;

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
      required String image}) async {
    String response = "";
    try {
      String userId = user.uid;

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
        "image": ""
      });
      response = "success";
    } catch (error) {
      response = error.toString();
    }
    return response;
  }

  //get all clients
  Stream<QuerySnapshot<Map<String, dynamic>?>> getClients() {
    return _firestore.collection('clients').snapshots();
  }
}
