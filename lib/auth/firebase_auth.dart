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
  static final _instance = Firebaseauthservice._private();
  Firebaseauthservice._private();
  factory Firebaseauthservice() => _instance;

  @override
  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  @override
  Future loginUser(String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential;
  }

  @override
  Future createUser(String name, String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await userCredential.user!.updateDisplayName(name); //update the name parament for the user
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
  Future sendEmailVerification(User? user) async {
    return await user?.sendEmailVerification();
  }
}

class FinanceappProvider with ChangeNotifier {
  bool isloading = false;
  late String errormessage;
  late UserCredential userCredential;

  final _firebaseauth = Firebaseauthservice();

  User? currentuser() {
    return _firebaseauth.getCurrentUser();
  }

  Future createuser(String name, String email, String password) async {
    isloading = true;
    notifyListeners();

    // await Future.delayed(Duration(seconds: 4));

    try {
      userCredential = await _firebaseauth.createUser(name, email, password);
      await _firebaseauth.sendEmailVerification(currentuser());
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

  Future loginUser(String email, String password) async {
    isloading = true;
    notifyListeners();

    try {
      userCredential = await _firebaseauth.loginUser(email, password);
      isloading = false;
      notifyListeners();

      return userCredential;
    } catch (e) {
      errormessage = e.toString();
      isloading = false;
      notifyListeners();
      return errormessage;
    }
  }

  Future reloadUser() async {
    try {
      await _firebaseauth.getCurrentUser()?.reload();
    } catch (e) {
      errormessage = e.toString();
    }
  }

  Future resendemailverifcation() async {
    try {
      await _firebaseauth.sendEmailVerification(currentuser());
    } catch (e) {
      errormessage = e.toString();
      errormessage;
    }
  }
}
