import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  final FirebaseAuth auth = FirebaseAuth.instance;
  Map<String, dynamic> extractedUserData = {};
  Map<String, dynamic> user = {};
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  Future addUserData(String uid, String name, String lastName, String email,
      String gender, String photo) async {
    return await userCollection.doc(uid).set({
      "name": name,
      "lastName": lastName,
      "email": email,
      "gender": gender,
      "profilePic": photo,
      "role":"patient",
      "rehabs":[]
    });
  }

  UserData(String uid) async {
    return userCollection.doc(uid).get();
  }
  signOut() async {
    await auth.signOut();
  }
}
