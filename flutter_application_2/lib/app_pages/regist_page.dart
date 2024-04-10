import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/my_textfield.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({super.key});
  final TextEditingController userName_1  = TextEditingController();
  final TextEditingController wardNo  = TextEditingController();
  final TextEditingController mobNo  = TextEditingController();
  final TextEditingController password_1  = TextEditingController();
  final TextEditingController confirmPass = TextEditingController();

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
            
                Text("Let's Get Started!",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            
                 SizedBox(height: 0.5),
            
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 25),
                  child: Text("Create an account to avail all features"),
                ),
            
                 SizedBox(height: 10),
            
                MyTextField(
                  controller: userName_1, 
                  hintText: "Username", 
                  obscureText: false
                  ),
            
                 SizedBox(height: 10),
            
                MyTextField(
                  controller: wardNo, 
                  hintText: "Ward no", 
                  obscureText: false
                  ),
            
                 SizedBox(height: 10),
            
                MyTextField(
                  controller: mobNo, 
                  hintText: "Mobile no", 
                  obscureText: false
                  ),
            
                 SizedBox(height: 10),
            
                MyTextField(
                  controller: password_1, 
                  hintText: "Password", 
                  obscureText: true),
            
                 SizedBox(height: 10),
            
                MyTextField(
                  controller: confirmPass, 
                  hintText: "Confirm Password", 
                  obscureText: true),
            
                   SizedBox(height: 20),
            
                  ElevatedButton(
                    onPressed: (){
                      Navigator.pushNamed(context, 'z');
                    }, 
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black
                    ),
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
