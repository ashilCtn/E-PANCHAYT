import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/my_button_new.dart';
import 'package:flutter_application_2/components/my_textform_field.dart';
import 'package:flutter_application_2/services/firestore_register.dart';

class GoogleReg extends StatefulWidget {
  GoogleReg({Key? key}) : super(key: key);

  @override
  State<GoogleReg> createState() => _GoogleRegState();
}

class _GoogleRegState extends State<GoogleReg> {
  final TextEditingController _userName_1 = TextEditingController();
  final TextEditingController _wardNo = TextEditingController();
  final TextEditingController _mobNo = TextEditingController();
  final GlobalKey<FormState> formKeyGR = GlobalKey<FormState>();
  final FireStoreRegister fireStoreRegister = FireStoreRegister();
  String email = '';

  @override
  void initState() {
    super.initState();
    // Initialize email with current user's email
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        email = user.email ?? '';
      });
    }

    // Listen for changes in user authentication state
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          email = user.email ?? '';
        });
      }
    });
  }

  String? validatePhoneNum(value) {
    if (value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (value.length != 10) {
      return 'Please enter a 10-digit phone number';
    }
    return null;
  }

  void submitGoogleRegist() async {
    if (formKeyGR.currentState!.validate()) {
      try {
        // Navigate to 'z' screen
        Navigator.pop(context);
        Navigator.pushNamed(context, 'z');
        print("&&&&&&&&&&&&&&&&&&&&&&&&");

        // Add user details to Firestore
        fireStoreRegister.addGoogleUserDetails(
          _userName_1.text.trim(),
          email, // Use the email retrieved
          _wardNo.text.trim(),
          _mobNo.text.trim(),
        );

        // Navigate back
      } catch (e) {
        print('Error adding user details: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  "One Time for Google user",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 0.5),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Text("Carefully fill the below details"),
                ),
                const SizedBox(height: 10),
                Form(
                  key: formKeyGR,
                  child: Column(
                    children: [
                      MyTextFormField(
                        controller: _userName_1,
                        hintText: "Username",
                        obscureText: false,
                        iconName: "person_alt_circle_fill",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a username';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      MyTextFormField(
                        controller: _wardNo,
                        hintText: "Ward no",
                        obscureText: false,
                        iconName: "building",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the ward number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      MyTextFormField(
                        controller: _mobNo,
                        hintText: "Mobile no",
                        obscureText: false,
                        iconName: "phone",
                        validator: validatePhoneNum,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                MyNewButton(
                  onTap: submitGoogleRegist,
                  text: "Add Details",
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
