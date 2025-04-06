import 'package:finance_app/Screens%20/SignupScreen.dart';
import 'package:finance_app/Screens%20/inputnumberscreen%20.dart';
import 'package:finance_app/Screens%20/loginscreen.dart';
import 'package:finance_app/Screens%20/verificationcodescreen.dart';
import 'package:finance_app/auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data == null) {
            return InputPhoneNum();
          }
          if (snapshot.data != null) {
            print('not null');
            if (snapshot.data!.emailVerified == false) {
              return InputPhoneNum();
            }
          }
          return LoginScreenScreen();
        },
      ),
    );
  }
}

class Logo extends CustomPainter {
  final double positionLogo;

  const Logo(this.positionLogo);

  @override
  void paint(Canvas canvas, Size size) {
    double appBarHeight = positionLogo; // Default AppBar height in Flutter
    Rect rect = Offset(0, appBarHeight) & const Size(35.0, 35.0); // Positioned at the left, under AppBar
    double padding = rect.width * 0.24; // Space between lines and box edges
    double gap = (rect.width - (2 * padding)) / 3; // Equal spacing for the three lines

    Paint paint =
        Paint()
          ..strokeWidth = 4
          ..style = PaintingStyle.stroke
          ..color = const Color.fromARGB(1000, 50, 66, 154);

    // Adjusted rectangle for lines to avoid touching edges
    Rect innerRect = Rect.fromLTRB(
      rect.left + padding,
      rect.top + padding,
      rect.right - padding,
      rect.bottom - padding,
    );
    canvas.drawRect(rect, paint); // Draw the outer rectangle

    // Middle diagonal line (longest, full box, but with padding)
    canvas.drawLine(innerRect.topLeft, innerRect.bottomRight, paint);

    // Shorter diagonal near B (top-right), with padding
    canvas.drawLine(
      Offset(innerRect.right - gap, innerRect.top), // Start near top-right (B)
      Offset(innerRect.right, innerRect.top + gap), // End going downward from B
      paint,
    );

    // Shorter diagonal near C (bottom-left), with padding
    canvas.drawLine(
      Offset(innerRect.left, innerRect.bottom - gap), // Start near bottom-left (C)
      Offset(innerRect.left + gap, innerRect.bottom), // End going right from C
      paint,
    );
  }

  @override
  bool shouldRepaint(Logo oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(Logo oldDelegate) => false;
}

class CustomTextfield extends StatefulWidget {
  final TextEditingController controller;
  final String labelname;
  final TextInputType? inputtype;

  const CustomTextfield(this.controller, this.labelname, {this.inputtype, super.key});

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  Icon passwordShowIcon = Icon(Icons.visibility);
  bool ishidetext = false;
  @override
  Widget build(BuildContext context) {
    return TextField(
      autocorrect: false,
      controller: widget.controller,
      decoration: InputDecoration(
        suffixIcon:
            widget.labelname == "Password"
                ? IconButton(
                  icon: passwordShowIcon,
                  onPressed: () {
                    setState(() {
                      if (ishidetext == true) {
                        ishidetext = false;
                        passwordShowIcon = Icon(Icons.visibility);
                      } else {
                        ishidetext = true;
                        passwordShowIcon = Icon(Icons.visibility_off);
                      }
                      print(ishidetext);
                    });
                  },
                )
                : null,
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        labelText: widget.labelname,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        ),
      ),
      keyboardType: widget.inputtype,
      obscureText: ishidetext,
    );
  }
}

Widget customButton(BuildContext context, String text, {VoidCallback? onpressed}) {
  return Container(
    padding: EdgeInsets.only(top: 30),
    width: MediaQuery.of(context).size.width, // 70% of screen width
    height: 105, // Increased height for better appearance

    child: ElevatedButton(
      onPressed: onpressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(1000, 50, 66, 154), // Button color
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(15.0)), // Rounded corners
        ),
      ),

      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white, // Text color
        ),
      ),
    ),
  );
}
