import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moneymanager/core/models/user.dart';

class AuthServices {
  var userCollection = FirebaseFirestore.instance.collection('users');

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> signIn(String emailController, String passwordController) async {
    try {
      await auth.signInWithEmailAndPassword(email: emailController, password: passwordController);
      print("done");
      return true;
    } on FirebaseException catch (e) {
      print(e.message);
      return false;
    }
  }

  Future<bool> signUp(String emailController, String passwordController, String name) async {
    try {
      await auth.createUserWithEmailAndPassword(email: emailController, password: passwordController);

      await saveUser(AppUser(uid: user!.uid, userName: name, email: emailController));
      return true;
    } on FirebaseException catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> resetPassword(String emailController) async {
    try {
      await auth.sendPasswordResetEmail(email: emailController);
      return true;
    } on FirebaseException catch (e) {
      return false;
    }
  }

  saveUser(AppUser user) async {
    try {
      await userCollection.doc(user.uid).set(user.Tojson());
    } catch (e) {}
  }

  User? get user => auth.currentUser;
}
