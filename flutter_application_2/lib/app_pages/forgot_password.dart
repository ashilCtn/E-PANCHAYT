import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/my_button_new.dart';
import 'package:flutter_application_2/components/my_textform_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _forgotpassController = TextEditingController();

  @override
  void dispose() {
    _forgotpassController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      FirebaseAuth.instance
          .sendPasswordResetEmail(email: _forgotpassController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text(
                  'Valid Email!\nPassword Reset link sent to your registered email'),
            );
          });
    } on FirebaseAuthException catch (e) {
      //print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        elevation: 0,
      ),
      backgroundColor: Colors.blueGrey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Enter the email address associated with your account and we'll send you a link to reset your password",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(height: 10),
          // MyTextField(
          //   controller: _forgotpassController,
          //   hintText: "Registered Email",
          //   obscureText: false,
          // ),
          MyTextFormField(
            hintText: "Email",
            validator: null,
            controller: _forgotpassController,
            obscureText: false,
            iconName: "email",
          ),
          const SizedBox(height: 10),
          MyButton1(onTap: passwordReset, text: "Reset Password"),
          // MaterialButton(
          //   onPressed: passwordReset,
          //   color: Colors.black12,
          //   child: const Text('Reset Password'),
          // )
        ],
      ),
    );
  }
}
