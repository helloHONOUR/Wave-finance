import 'dart:async';
import 'package:finance_app/Screens%20/loginscreen.dart';
import 'package:finance_app/auth/firebase_auth.dart';
import 'package:finance_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool _canResendEmail = true;
  bool _isChecking = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // sendVerificationEmail();

    // Optional: auto-check every 5 seconds
    // _timer = Timer.periodic(Duration(seconds: 5), (_) => checkEmailVerified());
  }

  // @override
  // void dispose() {
  //   _timer.cancel();
  //   super.dispose();
  // }

  // Future<void> sendVerificationEmail() async {
  //   try {
  //     final user = FirebaseAuth.instance.currentUser!;
  //     await user.sendEmailVerification();
  //     setState(() => _canResendEmail = false);

  //     // cooldown
  //     await Future.delayed(Duration(seconds: 30));
  //     setState(() => _canResendEmail = true);

  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Verification email sent!')));
  //   } catch (e) {
  //     print('Error sending email: $e');
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Could not send verification email.')));
  //   }
  // }

  // Future<void> checkEmailVerified() async {
  //   setState(() => _isChecking = true);

  //   await FirebaseAuth.instance.currentUser!.reload();
  //   final user = FirebaseAuth.instance.currentUser;

  //   if (user!.emailVerified) {
  //     _timer.cancel();
  //     if (!mounted) return;

  //     // Navigate to the next screen
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => LoginScreen()), // replace with your actual HomePage
  //     );
  //   } else {
  //     setState(() => _isChecking = false);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FinanceappProvider>(context, listen: true);
    final user = provider.currentuser();
    // final userEmail = FirebaseAuth.instance.currentUser?.email ?? '';

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 60),
          child: Column(
            children: [
              Container(
                // color: Colors.black,
                height: 40,
                child: Align(alignment: Alignment.topLeft, child: CustomPaint(size: Size(35, 35), painter: Logo(0))),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(bottom: 10, top: 20),
                child: Text('Verify Your Email', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ),
              //
              Container(
                padding: EdgeInsets.only(top: 30),
                alignment: Alignment.center,
                child: Image.asset('assets/send.png', height: 200, width: 150),

                //  Icon(Icons.email_outlined, size: 100, color: Colors.blueAccent),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.only(bottom: 10, top: 10),
                child: Text('Verification email sent to:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300)),
              ),
              // Text('Verification email sent to', style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
              Text(
                '${user?.email}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(1000, 50, 66, 154),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              customButton(
                () {
                  provider.isloading = false;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ),
                  );
                },
                'Back to login',
                false,
              ),
              // ElevatedButton.icon(
              //   onPressed: () {},
              //   //  _canResendEmail ? sendVerificationEmail : null,
              //   icon: Icon(Icons.send),
              //   label: Text('Resend Email'),
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Color(0xFF32429A),
              //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              //   ),
              // ),
              SizedBox(height: 20),

              SizedBox(height: 30),
              Text(
                "Didn’t receive it? Click the resend email",
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),

              TextButton(
                onPressed: () {
                  // FirebaseAuth.instance.signOut();
                  provider.resendemailverifcation();
                },
                child: Text('Resend email'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
