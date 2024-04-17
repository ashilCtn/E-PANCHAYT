import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/my_textfield.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({super.key});
  final TextEditingController _userName_1 = TextEditingController();
  final TextEditingController _emailId = TextEditingController();
  final TextEditingController _wardNo = TextEditingController();
  final TextEditingController _mobNo = TextEditingController();
  final TextEditingController _password_1 = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  bool passwordConfirmed() {
    if (_password_1.text.trim() == _confirmPass.text.trim()) {
      return true;
    } else {
      return false;
    }
    //tip!! >> add a pop up for showing the pass and confirm pass donot match
  }

  Future registerFunc() async {
    //just create a new user and password
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailId.text.trim(), password: _password_1.text.trim());
    }
    //add user details
    addNormalUserDetails(
        _userName_1.text.trim(),
        _emailId.text.trim(),
        int.parse(_wardNo.text.trim()),
        int.parse(_mobNo.text.trim()),
        _password_1.text.trim());
  }

  //function of firestore collection method in flutter to upload data to DB
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 100),
                Text(
                  "Let's Get Started!",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 0.5),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Text("Create an account to avail all features"),
                ),
                SizedBox(height: 10),
                MyTextField(
                    controller: _userName_1,
                    hintText: "Username",
                    obscureText: false),
                SizedBox(height: 10),
                MyTextField(
                    controller: _emailId,
                    hintText: "Email",
                    obscureText: false),
                SizedBox(height: 10),
                MyTextField(
                    controller: _wardNo,
                    hintText: "Ward no",
                    obscureText: false),
                SizedBox(height: 10),
                MyTextField(
                    controller: _mobNo,
                    hintText: "Mobile no",
                    obscureText: false),
                SizedBox(height: 10),
                MyTextField(
                    controller: _password_1,
                    hintText: "Password",
                    obscureText: true),
                SizedBox(height: 10),
                MyTextField(
                    controller: _confirmPass,
                    hintText: "Confirm Password",
                    obscureText: true),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    //Navigator.pushNamed(context, 'z');
                    registerFunc();
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    SizedBox(width: 1),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'y');
                        //
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.black,
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
