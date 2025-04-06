import 'package:finance_app/Screens%20/inputnumberscreen%20.dart';
import 'package:finance_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class VerifycodeScreen extends StatefulWidget {
  const VerifycodeScreen({super.key});

  @override
  State<VerifycodeScreen> createState() => _VerifycodeScreenState();
}

class _VerifycodeScreenState extends State<VerifycodeScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(child: CustomPaint(size: Size(50, 50), painter: Logo(10))),
            ),

            Container(
              padding: EdgeInsets.only(bottom: 10, top: 10),
              child: Text('Enter Verification code', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10, top: 10),
              child: Text(
                'We have sent the code verification to your mobile number',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 30)),
            OtpTextField(
              textStyle: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),

              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, // Restricts input to numbers only
              ],
              keyboardType: TextInputType.number,
              clearText: true,
              margin: EdgeInsets.only(right: 15),
              borderWidth: 2,
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              numberOfFields: 5, // Number of OTP boxes
              borderColor: const Color.fromARGB(1000, 50, 66, 154), // Border color
              showFieldAsBox: true, // Show box-like fields
              fieldWidth: 60, // Width of each box
              fieldHeight: 56,
              onCodeChanged: (String code) {
                // Handle change
              },
              onSubmit: (String verificationCode) {
                // Handle OTP submit
                print("OTP Entered: $verificationCode");
              },
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Resend code',
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: const Color.fromARGB(1000, 50, 66, 154),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 30)),
            Flexible(
              child: SafeArea(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: customButton(context, 'Verify account', onpressed: () {}),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
