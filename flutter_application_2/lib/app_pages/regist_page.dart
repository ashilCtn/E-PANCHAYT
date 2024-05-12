import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/loading.dart';
import 'package:flutter_application_2/components/my_textform_field.dart';
import 'package:flutter_application_2/components/obscure_textformfield.dart';
import 'package:flutter_application_2/components/my_button_new.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({super.key});
  final TextEditingController _userName_1 = TextEditingController();
  final TextEditingController _wardNo = TextEditingController();
  final TextEditingController _mobNo = TextEditingController();
  final TextEditingController _password_1 = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final TextEditingController _emailId = TextEditingController();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();

  bool passwordConfirmed() {
    if (_password_1.text.trim() == _confirmPass.text.trim()) {
      return true;
    } else {
      return false;
    }
    //tip!! >> add a pop up for showing the pass and confirm pass donot match
  }

  Future addNormalUserDetails(String userName, String email, int wardno,
      int mobileno, String password) async {
    await FirebaseFirestore.instance.collection('NormalUsers').add({
      'Username': userName,
      'Email': email,
      'Wardno': wardno,
      'Mobileno': mobileno,
      'Password': password,
    });
  }

  Future registerFunc(BuildContext context) async {
    Loader.showLoadingDialog(context);
    // Just create a new user and password
    if (passwordConfirmed()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailId.text.trim(), password: _password_1.text.trim());

        Navigator.pushNamed(context, 'z');

        // Add user details
        addNormalUserDetails(
            _userName_1.text.trim(),
            _emailId.text.trim(),
            int.parse(_wardNo.text.trim()),
            int.parse(_mobNo.text.trim()),
            _password_1.text.trim());
      } catch (e) {
        print("Error creating user: $e");
        Navigator.of(context).pop();
      }
    }
  }

  void _submitRegisterForm(BuildContext context) {
    if (formKey2.currentState!.validate()) {
      // Navigator.pushNamed(context, 'z');
      registerFunc(context);
    }
  }

  String? _validatePhoneNum(value) {
    if (value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (value.length != 10) {
      return 'Please enter a 10-digit phone number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 100),
                const Text(
                  "Let's Get Started!",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 0.5),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Text("Create an account to avail all features"),
                ),
                const SizedBox(
                  height: 10,
                ),
                Form(
                  key: formKey2,
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
                          hintText: "Email",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your email";
                            }
                            RegExp emailRegExp =
                                RegExp(r'^[\w-\.]+@([\w-]+\.)+[a-zA-Z]{2,4}$');
                            if (!emailRegExp.hasMatch(value)) {
                              return 'Please enter a Valid email';
                            }
                            return null;
                          },
                          controller: _emailId,
                          obscureText: false,
                          iconName: "email"),
                      const SizedBox(
                        height: 10,
                      ),
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
                        validator: _validatePhoneNum,
                      ),
                      const SizedBox(height: 10),
                      ObsTextFormField(
                        hintText: "Password",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a Password';
                          }
                          return null;
                        },
                        controller: _password_1,
                      ),
                      const SizedBox(height: 10),
                      ObsTextFormField(
                        hintText: "Password",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a Password';
                          }
                          if (_password_1.text != _confirmPass.text) {
                            return 'Password do not match';
                          }
                          return null;
                        },
                        controller: _confirmPass,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                MyNewButton(
                    onTap: () {
                      _submitRegisterForm(context);
                    },
                    text: "Register"),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    const SizedBox(width: 1),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'y');
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          // color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
