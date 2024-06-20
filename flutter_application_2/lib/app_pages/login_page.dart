import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_2/app_pages/forgot_password.dart';
import 'package:flutter_application_2/auth/google_signin.dart';
import 'package:flutter_application_2/components/obscure_textformfield.dart';
import 'package:flutter_application_2/components/my_textform_field.dart';
import 'package:flutter_application_2/components/my_button_new.dart';
import 'package:flutter_application_2/components/square_tile.dart';
import 'package:flutter_application_2/core/theme/app_pallete.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> _submitForm() async {
    if (formKey.currentState!.validate()) {
      try {
        // Show loading dialog
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
            child: SpinKitSpinningLines(
              color: AppPallete.whiteColor,
              size: 80,
            ),
          ),
        );

        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text.trim(),
          password: password.text.trim(),
        );

        // Pop the loading dialog and navigate to the FunPage
        Navigator.of(context).popUntil((route) => route.isFirst);
      } on FirebaseAuthException catch (e) {
        String errorMessage =
            "Please Check Your Internet Connection and Try Again...";
        if (e.code == 'invalid-credential') {
          errorMessage = "Please Check User Credentials !!";
        } else if (e.code == 'too-many-requests') {
          errorMessage = "Too-Many-Requests\nTry Again Later...";
        }

        Navigator.of(context).pop(); // Close loading dialog

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    errorMessage,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: AppPallete.greyColor,
            elevation: 0,
            margin: const EdgeInsets.all(20),
            padding: EdgeInsets.zero,
          ),
        );
      } catch (e) {
        Navigator.of(context).pop(); // Close loading dialog
      }
    }
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
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
    print('google sign in\n');
  }

  void forgotPass() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const ForgotPasswordPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Are you sure?"),
              content: const Text("Do you want to exit from the app?"),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text("NO"),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text("YES"),
                ),
              ],
            );
          },
        );
        if (value != null) {
          return Future.value(value);
        } else {
          return Future.value(false);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 120),
                  const Text(
                    "e-Panchayat",
                    style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
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
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => forgotPass(),
                          child: const Text(
                            "Forgot password?",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  MyNewButton(onTap: _submitForm, text: "Login"),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      const Text("  Or continue with  "),
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
                        onTap: () => GoogleSignInService().signInWithGoogle(),
                        imagePath: 'lib/img/google.png',
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
                          "Register Now! ",
                          style: TextStyle(
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
      ),
    );
  }
}
