import 'package:barkcode/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  FirebaseAuthService(this._firebaseAuth);

  Future<dynamic> logIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-login-credentials') {
        return 'Wrong email or password.';
      }
      return e.code;
    }
  }

  Future<dynamic> signUp(
      {required String email,
      required String password,
      required String name}) async {
    try {
      var result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      await setUpUser(name: name, id: result.user!.uid, email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  Future<dynamic> setUpUser(
      {required String name, required String id, required String email}) async {
    try {
      Map<String, dynamic> data = {
        "id": id,
        "email": email,
        "name": name,
      };
      await users.doc(id).set(data);
      // _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<UserFirebase> getName() async {
    var uid = _firebaseAuth.currentUser?.uid ?? "";

    var qSnapShot = await users.doc(uid).get();

    Object? response = qSnapShot.data();
    return UserFirebase.fromJson(response as Map<String, dynamic>);
  }
}
