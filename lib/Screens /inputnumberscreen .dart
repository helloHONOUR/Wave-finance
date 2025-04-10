import 'package:finance_app/Screens%20/verificationcodescreen.dart';
import 'package:finance_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final TextEditingController phonenumController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(countries[1].name);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(alignment: Alignment.topLeft, child: CustomPaint(size: Size(50, 150), painter: Logo(100))),

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

            // CustomTextfield(phonenumController, 'phonenumber'),
            // IntlPhoneField(
            //   // dropdownIconPosition: IconPosition.trailing,
            //   dropdownDecoration: BoxDecoration(borderRadius: BorderRadius.circular(1)),
            //   dropdownIcon: Icon(Icons.keyboard_arrow_down_rounded),

            //   inputFormatters: [
            //     FilteringTextInputFormatter.digitsOnly, // Restricts input to numbers only
            //   ],
            //   keyboardType: TextInputType.number,
            //   decoration: InputDecoration(
            //     labelText: 'Phone Number',
            //     border: OutlineInputBorder(borderSide: BorderSide()),
            //   ),
            //   initialCountryCode: 'US',
            //   onChanged: (phone) {
            //     print(phone);
            //   },
            // ),
            PhoneNumTextfield(controller: phonenumController),
            Padding(padding: EdgeInsets.only(bottom: 30)),
            Flexible(
              child: SafeArea(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: customButton(
                    () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => VerifycodeScreen()));
                    },
                    'Verify account',
                    false,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PhoneNumTextfield extends StatefulWidget {
  final TextEditingController controller;

  const PhoneNumTextfield({super.key, required this.controller});

  @override
  State<PhoneNumTextfield> createState() => _PhoneNumTextfieldState();
}

class _PhoneNumTextfieldState extends State<PhoneNumTextfield> {
  Country? country = countries[40];

  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly, // Restricts input to numbers only
      ],
      controller: widget.controller,
      autocorrect: false,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        // This disables interaction with the prefix icon affecting the text field
        // prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0), // Makes it tighter
        prefixIcon: PopupMenuButton(
          onSelected: (value) {
            setState(() {
              country = value;
            });
          },
          position: PopupMenuPosition.under,
          constraints: BoxConstraints.loose(Size(300, 400)),
          itemBuilder: (BuildContext context) {
            return countries.map((country) {
              return PopupMenuItem(
                value: country,
                child: ListTile(
                  title: Text(country.name),
                  leading: Text(country.flag, style: TextStyle(fontSize: 25)),
                  trailing: Text('+${country.dialCode}'),
                ),
              );
            }).toList();
            // ListView.builder(
            //   itemCount: countries.length,
            //   itemBuilder: (BuildContext context, int index) {
            //     return ListTile(
            //       title: Text(countries[index].name),
            //       leading: Text(countries[index].flag, style: TextStyle(fontSize: 25)),
            //       trailing: Text('+${countries[index].dialCode}'),
            //     );
            //   },
            // );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.keyboard_arrow_down_rounded, size: 25),
                SizedBox(width: 4),
                Text(country!.flag, style: TextStyle(fontSize: 18)),
                SizedBox(width: 4),
                Text('+${country!.dialCode}'),
              ],
            ),
          ),
        ),
        labelText: 'Phone Number',
        // border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
    );
  }
}
