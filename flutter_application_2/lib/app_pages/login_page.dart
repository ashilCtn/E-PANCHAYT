import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_2/app_pages/regist_page.dart';
import 'package:flutter_application_2/components/my_button.dart';
import 'package:flutter_application_2/components/my_textfield.dart';
import 'package:flutter_application_2/components/square_tile_new.dart';
import 'functionality_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();
  void googleSignIn() {
    print("x");
  }
  void forgotPass(){}

  void faceBookSingIn() {}
  
  void signUserIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userName.text, password: password.text);
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
                SizedBox(height: 10),
                Text(
                  "e-Panchayat",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 42,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 25,
                ),
                MyTextField(
                  controller: userName,
                  hintText: "Username",
                  obscureText: false,
                ),
                SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller: password,
                  hintText: "Password",
                  obscureText: true,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => forgotPass,
                        child: Text(
                          "Forgot password",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                //MyButton(onTap: signUserIn),
                ElevatedButton(
                    onPressed: () {
                      //Navigator.pushNamed(context, 'z');
			signUserIn();
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    )),

                SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Text("Or continue with"),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile1(
                      onTap: () => googleSignIn,
                      imagePath: 'lib/img/google.png',
                      ),
                    SizedBox(width: 20),
                    SquareTile1(
                      onTap: () => faceBookSingIn,
                      imagePath: "lib/img/facebook.png",
                      ),
                  ],
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    SizedBox(width: 1),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'x');
                      },
                      child: Text(
                        "Register",
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
        )
      )
    );
  }
}
