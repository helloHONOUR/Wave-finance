import 'package:finance_app/auth/firebase_auth.dart';
import 'package:finance_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(alignment: Alignment.topLeft, child: CustomPaint(size: Size(50, 150), painter: Logo(100))),

            Container(
              padding: EdgeInsets.only(bottom: 10, top: 10),
              child: Text('Join StockWave ', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10, top: 10),
              child: Text(
                'Embark on your investment journey with a single dollar ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 30)),
            CustomTextfield(nameController, "Name"),
            // customTextfield(nameController, "Name"),
            Padding(padding: EdgeInsets.only(bottom: 18)),
            CustomTextfield(emailController, "Gmail", inputtype: TextInputType.emailAddress),

            Padding(padding: EdgeInsets.only(bottom: 18)),
            CustomTextfield(passwordController, "Password"),

            customButton(
              context,
              'Sign in',
              onpressed: () {
                Firebaseauthservice().createUser(nameController.text, emailController.text, passwordController.text);
              },
            ),
            Padding(padding: EdgeInsets.only(bottom: 10)),

            Padding(padding: EdgeInsets.only(bottom: 30)),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Container(
                    height: 2,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: const Color.fromARGB(255, 196, 197, 198),
                    ),
                  ),
                ), // Left line
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    "Or continue with",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromARGB(255, 126, 127, 129),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 2,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: const Color.fromARGB(255, 196, 197, 198),
                    ),
                  ),
                ),
              ],
            ),

            Padding(padding: EdgeInsets.only(bottom: 30)),
            Column(
              children: [
                TextButton(
                  onPressed: () {},

                  // icon: Image.asset("assets/google_logo.png", height: 24), // Google logo
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    maximumSize: Size(MediaQuery.of(context).size.width, 50),
                    minimumSize: Size(MediaQuery.of(context).size.width, 50),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: const Color.fromARGB(255, 196, 197, 198)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text("Sign in with Google"),
                ),

                Padding(padding: EdgeInsets.only(bottom: 16)),
                TextButton(
                  onPressed: () async {},

                  // icon: Image.asset("assets/google_logo.png", height: 24), // Google logo
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    maximumSize: Size(MediaQuery.of(context).size.width, 50),
                    minimumSize: Size(MediaQuery.of(context).size.width, 50),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: const Color.fromARGB(255, 196, 197, 198)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text("Continue with Apple"),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 32)),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an accout? ",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 126, 127, 129),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromARGB(1000, 50, 66, 154),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
