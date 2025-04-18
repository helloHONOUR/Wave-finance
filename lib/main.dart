import 'package:finance_app/Screens%20/SignupScreen.dart';
import 'package:finance_app/Screens%20/homescreen.dart';
import 'package:finance_app/Screens%20/inputnumberscreen%20.dart';
import 'package:finance_app/Screens%20/loginscreen.dart';
import 'package:finance_app/Screens%20/sendverificationemail.dart';
import 'package:finance_app/Screens%20/verificationcodescreen.dart';
import 'package:finance_app/auth/firebase_auth.dart';
import 'package:finance_app/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final TextTheme customTextTheme = TextTheme(
  // Body XLarge (18px)
  displayLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w700), // Bold
  displayMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600), // Semibold
  displaySmall: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.grey, letterSpacing: 1), // Medium
  headlineLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w400), // Regular
  // Body Large (16px)
  headlineMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black), // Bold
  headlineSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w600), // Semibold
  titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500), // Medium
  titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w400), // Regular
  // Body Medium (14px)
  titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w700), // Bold
  bodyLarge: TextStyle(fontSize: 25, fontWeight: FontWeight.w800), // Semibold
  bodyMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w700), // Medium
  bodySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey), // Regular
  // Body Small (12px)
  labelLarge: TextStyle(fontSize: 12, fontWeight: FontWeight.w700), // Bold
  labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w600), // Semibold
  labelSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w500), // Medium
  // Body XSmall (10px)
  // Custom access manually from theme extension or map
);

class Share {
  final String shortName;
  final String fullName;
  final String logo; // asset path or URL
  final String recentChange;
  final bool isPositive;

  Share({
    required this.shortName,
    required this.fullName,
    required this.logo,
    required this.recentChange,
    required this.isPositive,
  });
}

List<Share> dummyShares = [
  Share(
    shortName: 'AAPL',
    fullName: 'Apple Inc.',
    logo: 'assets/logos/apple.png',
    recentChange: '+1.23%',
    isPositive: true,
  ),
  Share(
    shortName: 'TSLA',
    fullName: 'Tesla Inc.',
    logo: 'assets/logos/tesla.png',
    recentChange: '-0.75%',
    isPositive: false,
  ),
  Share(
    shortName: 'AMZN',
    fullName: 'Amazon.com Inc.',
    logo: 'assets/logos/amazon.png',
    recentChange: '+2.10%',
    isPositive: true,
  ),
  Share(
    shortName: 'GOOGL',
    fullName: 'Alphabet Inc.',
    logo: 'assets/logos/google.png',
    recentChange: '+0.65%',
    isPositive: true,
  ),
  Share(
    shortName: 'MSFT',
    fullName: 'Microsoft Corp.',
    logo: 'assets/logos/microsoft.png',
    recentChange: '-1.15%',
    isPositive: false,
  ),
  Share(
    shortName: 'META',
    fullName: 'Meta Platforms Inc.',
    logo: 'assets/logos/meta.png',
    recentChange: '+0.95%',
    isPositive: true,
  ),
  Share(
    shortName: 'NVDA',
    fullName: 'Nvidia Corp.',
    logo: 'assets/logos/nvidia.png',
    recentChange: '+3.45%',
    isPositive: true,
  ),
  Share(
    shortName: 'WMT',
    fullName: 'Walmart Inc.',
    logo: 'assets/logos/walmart.png',
    recentChange: '-0.30%',
    isPositive: false,
  ),
  Share(
    shortName: 'FAKE1',
    fullName: 'Quantum Solutions Inc.',
    logo: 'assets/logos/quantum.png',
    recentChange: '+5.67%',
    isPositive: true,
  ),
  Share(
    shortName: 'DEMO2',
    fullName: 'HyperNova Energy',
    logo: 'assets/logos/hypernova.png',
    recentChange: '-2.10%',
    isPositive: false,
  ),
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MultiProvider(providers: [ChangeNotifierProvider(create: (_) => FinanceappProvider())], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), textTheme: customTextTheme),
      routes: {
        'LoginView': (context) {
          return LoginScreen();
        },
      },
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data == null) {
            return SignupScreen();
          }
          if (snapshot.data != null) {
            if (snapshot.data!.emailVerified == false) {
              print(snapshot.data);
              return VerifyEmailScreen();
            }
          }
          return Homescreen();
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
    Rect rect = Offset(0, appBarHeight) & size; // Positioned at the left, under AppBar
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

class customButton extends StatefulWidget {
  final Function? onpressed;
  final dynamic text;
  final bool isloading;

  const customButton(this.onpressed, this.text, this.isloading, {super.key});

  @override
  State<customButton> createState() => _customButtonState();
}

class _customButtonState extends State<customButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30),
      width: MediaQuery.of(context).size.width, // 70% of screen width
      height: 105, // Increased height for better appearance

      child: ElevatedButton(
        onPressed: () {
          if (widget.onpressed != null) {
            widget.onpressed!();

            // print(provider.isloading);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(1000, 50, 66, 154), // Button color
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(15.0)), // Rounded corners
          ),
        ),

        child:
            widget.isloading
                ? CircularProgressIndicator(color: Colors.white)
                : Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Text color
                  ),
                ),
      ),
    );
  }
}

// Widget customtton(BuildContext context, String text, {VoidCallback? onpressed}) {
//   bool isloading = false;
//   return Container(
//     padding: EdgeInsets.only(top: 30),
//     width: MediaQuery.of(context).size.width, // 70% of screen width
//     height: 105, // Increased height for better appearance

//     child: ElevatedButton(
//       onPressed: () {
//         isloading = true;
//         onpressed;
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: const Color.fromARGB(1000, 50, 66, 154), // Button color
//         shape: RoundedRectangleBorder(
//           borderRadius: const BorderRadius.all(Radius.circular(15.0)), // Rounded corners
//         ),
//       ),

//       child:
//           isloading
//               ? CircularProgressIndicator()
//               : Text(
//                 text,
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white, // Text color
//                 ),
//               ),
//     ),
//   );
// }
