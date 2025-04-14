import 'package:finance_app/auth/firebase_auth.dart';
import 'package:finance_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // color: Colors.black,
                height: 40,
                child: Align(alignment: Alignment.topLeft, child: CustomPaint(size: Size(35, 35), painter: Logo(0))),
              ),

              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 10, top: 20),
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

              Consumer<FinanceappProvider>(
                builder: (context, provider, child) {
                  return customButton(
                    () async {
                      await provider.reloadUser();

                      // where the user clicks the signin button from the signup page
                      if (provider.currentuser() == null) {
                        provider.loginUser(emailController.text.trim(), passwordController.text.trim()).then((value) {
                          print(value);
                          if (value.runtimeType == UserCredential) {
                            if (context.mounted) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return Scaffold(
                                      body: Center(
                                        child: TextButton(
                                          onPressed: () {
                                            FirebaseAuth.instance.signOut();
                                          },
                                          child: Text('logout'),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                (_) {
                                  return false;
                                },
                              );
                            }
                          }
                        });
                      }
                      // where the normal signup to signin process is taken
                      else {
                        print('please verify email account');
                        if (provider.currentuser()!.emailVerified) {
                          provider.loginUser(emailController.text.trim(), passwordController.text.trim()).then((value) {
                            print(value);
                            if (value.runtimeType == UserCredential) {
                              print(value);
                              if (context.mounted) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Scaffold(
                                        body: Center(
                                          child: TextButton(
                                            onPressed: () {
                                              FirebaseAuth.instance.signOut();
                                            },
                                            child: Text('logout'),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  (_) {
                                    return false;
                                  },
                                );
                              }
                            }
                          });
                        } else {}
                      }
                    },
                    'Sign in',
                    provider.isloading ? true : false,
                  );
                },
              ),

              // customButton(, 'Sign in', false, () {}),
              Padding(padding: EdgeInsets.only(bottom: 10)),

              Align(
                alignment: AlignmentDirectional.topEnd,
                child: Container(
                  padding: EdgeInsets.only(bottom: 32),
                  // width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    onPressed: () {
                      // FirebaseAuth.instance.signOut();
                    },
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
      ),
    );
  }
}
