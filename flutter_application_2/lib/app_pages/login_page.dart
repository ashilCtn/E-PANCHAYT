import 'package:flutter/material.dart';
import 'package:flutter_application_2/app_pages/forgot_password.dart';
import 'package:flutter_application_2/components/obscure_textformfield.dart';
import 'package:flutter_application_2/components/my_textform_field.dart';
import 'package:flutter_application_2/components/my_button_new.dart';
import 'package:flutter_application_2/components/square_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //bool obscureText = true;

  void _submitForm() async {
    if (formKey.currentState!.validate()) {
      // Navigator.pushNamed(context, 'z');
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
    }
  }

  String? _validateEmail(value) {
    if (value!.isEmpty) {
      return "Please enter your email";
    }
    RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[a-zA-Z]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a Valid email';
    }
    return null;
  }

  void googleSignIn() {
    // print("x");
  }

  void forgotPass() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const ForgotPasswordPage();
    }));
  }

  void faceBookSingIn() {
    // print("Facebook Sign In");
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
                const SizedBox(height: 120),

                const Text(
                  "e-Panchayat",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 42,
                      fontWeight: FontWeight.bold),
                ),

                const SizedBox(
                  height: 15,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      MyTextFormField(
                        hintText: "Email",
                        validator: _validateEmail,
                        controller: email,
                        obscureText: false,
                        iconName: "email",
                      ),
                      const SizedBox(height: 20),
                      ObsTextFormField(
                        hintText: "Password",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a Password';
                          }
                          return null;
                        },
                        controller: password,
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => forgotPass(),
                        child: const Text(
                          "Forgot password?",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                //MyButton(onTap: signUserIn),
                /*ElevatedButton(
                    onPressed: _submitForm,
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
                    )),*/
                MyButton1(onTap: _submitForm, text: "Login"),

                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    const Text("Or continue with"),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(
                      onTap: googleSignIn,
                      imagePath: 'lib/img/google.png',
                    ),
                    const SizedBox(width: 20),
                    SquareTile(
                      onTap: faceBookSingIn,
                      imagePath: "lib/img/facebook.png",
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    const SizedBox(width: 1),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'x');
                      },
                      child: const Text(
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
        )));
  }
}
