import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class Auth {
  User? getCurrentUser();
  void loginUser(String email, String password) {}
  void createUser(String name, String email, String password);
  void deleteUser() {}
  void sendEmailVerification(User? user) {}
}

class Firebaseauthservice implements Auth {
  @override
  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  @override
  void loginUser(String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future createUser(String name, String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await userCredential.user!.updateDisplayName(name); //update the name parament for the user
    // return userCredential.user; //return the newuser
    return userCredential;
  }

  @override
  void deleteUser() async {
    try {
      await FirebaseAuth.instance.currentUser?.delete();
    } catch (e) {
      print(e);
    }
  }

  @override
  void sendEmailVerification(User? user) {
    user?.sendEmailVerification();
  }
}

class FinanceappProvider with ChangeNotifier {
  bool isloading = false;
  late String errormessage;
  late UserCredential userCredential;

  final firebaseauth = Firebaseauthservice();

  User? currentuser() {
    return firebaseauth.getCurrentUser();
  }

  Future createuser(String name, String email, String password) async {
    isloading = true;
    notifyListeners();

    // await Future.delayed(Duration(seconds: 4));

    try {
      userCredential = await firebaseauth.createUser(name, email, password);
      firebaseauth.sendEmailVerification(currentuser());
      isloading = false;
      notifyListeners();

      // await Future.delayed(Duration(seconds: 4));
      return userCredential;
    } catch (e) {
      errormessage = e.toString();
      isloading = false;
      notifyListeners();
      return errormessage;
    }
  }
}
