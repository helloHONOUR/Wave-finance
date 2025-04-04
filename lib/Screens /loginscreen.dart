import 'package:finance_app/main.dart';
import 'package:flutter/material.dart';

class LoginScreenScreen extends StatefulWidget {
  const LoginScreenScreen({super.key});

  @override
  State<LoginScreenScreen> createState() => _LoginScreenScreenState();
}

class _LoginScreenScreenState extends State<LoginScreenScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(alignment: Alignment.topLeft, child: CustomPaint(size: Size(50, 150), painter: Logo())),

            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 10, top: 10),
                  child: Text('Hi there!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ),
                Text('wave'),
              ],
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10, top: 10),
              child: Text(
                'Welcome back, Sign in to your account',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 30)),
            CustomTextfield(emailController, "Gmail", inputtype: TextInputType.emailAddress),
            Padding(padding: EdgeInsets.only(bottom: 18)),

            CustomTextfield(passwordController, "Password"),

            customButton(context, 'Sign in', onpressed: () {}),
            Padding(padding: EdgeInsets.only(bottom: 10)),

            Align(
              alignment: AlignmentDirectional.topEnd,
              child: Container(
                padding: EdgeInsets.only(bottom: 32),
                // width: MediaQuery.of(context).size.width,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot password?',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: const Color.fromARGB(1000, 50, 66, 154),
                    ),
                  ),
                ),
              ),
            ),

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

            //  decoration: BoxDecoration(
            //         border: Border.all(width: 1, color: const Color.fromARGB(255, 196, 197, 198)),
            //         borderRadius: BorderRadius.circular(8),
            //       ),

            //       width: MediaQuery.of(context).size.width,
            //       child:
            Padding(padding: EdgeInsets.only(bottom: 30)),
            Column(
              children: [
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
                  child: TextButton(
                    style: ButtonStyle(maximumSize: WidgetStateProperty.all(Size(75, 50))),
                    onPressed: () {},
                    child: Text(
                      'Sign up',

                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(1000, 50, 66, 154),
                      ),
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
