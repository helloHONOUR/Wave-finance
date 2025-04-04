import 'package:finance_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/countries.dart';

class InputPhoneNum extends StatefulWidget {
  const InputPhoneNum({super.key});

  @override
  State<InputPhoneNum> createState() => _InputPhoneNumState();
}

class _InputPhoneNumState extends State<InputPhoneNum> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController telephonenumController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(countries[1].name);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(alignment: Alignment.topLeft, child: CustomPaint(size: Size(50, 150), painter: Logo())),

            Container(
              padding: EdgeInsets.only(bottom: 10, top: 10),
              child: Text('Enter your phone number', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10, top: 10),
              child: Text(
                "You'll receive a 5 digit code for the phone number verification",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 30)),
            // CustomTextfield(telephonenumController, 'phonenumber'),
            IntlPhoneField(
              // dropdownIconPosition: IconPosition.trailing,
              dropdownDecoration: BoxDecoration(borderRadius: BorderRadius.circular(1)),
              dropdownIcon: Icon(Icons.keyboard_arrow_down_rounded),

              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, // Restricts input to numbers only
              ],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(borderSide: BorderSide()),
              ),
              initialCountryCode: 'US',
              onChanged: (phone) {
                print(phone);
              },
            ),
            // PhoneNumTextfield(),
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

// class PhoneNumTextfield extends StatefulWidget {
//   final TextEditingController controller;
//   final String labelname;

//   const PhoneNumTextfield({super.key, required this.controller, required this.labelname});

//   @override
//   State<PhoneNumTextfield> createState() => _PhoneNumTextfieldState();
// }

// class _PhoneNumTextfieldState extends State<PhoneNumTextfield> {
// Country? country;

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       autocorrect: false,
//       controller: widget.controller,
//       decoration: InputDecoration(
//         suffixIcon: Container(child: Row(children: [Expanded(child:Image(image: country ?? countries[]))])),
//         contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
//         labelText: widget.lablename,
//         border: OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.grey.shade400),
//           borderRadius: const BorderRadius.all(Radius.circular(15.0)),
//         ),
//       ),
//       keyboardType: widget.inputtype,
//       obscureText: ishidetext,
//     );
//     ;
//   }
// }
