import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

abstract class Auth {
  Future getCurrentUser();
  void loginUser(String email, String password) {}
  void createUser(String name, String email, String password);
  void deleteUser() {}
}

class Firebaseauthservice implements Auth {
  @override
  Future<User?> getCurrentUser() async {
    return FirebaseAuth.instance.currentUser;
  }

  @override
  void loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // return userCredential.user; //return the newuser
    } catch (e) {
      print(e);
      // return e.toString();
    }
  }

  @override
  void createUser(String name, String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user!.updateDisplayName(name); //update the name parament for the user
      // return userCredential.user; //return the newuser
    } catch (e) {
      print(e);
      // return e.toString();
    }
  }

  @override
  void deleteUser() async {
    try {
      await FirebaseAuth.instance.currentUser?.delete();
    } catch (e) {
      print(e);
    }
  }
}
