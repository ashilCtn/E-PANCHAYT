import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/loading.dart';
import 'package:flutter_application_2/components/my_textform_field.dart';
import 'package:flutter_application_2/components/obscure_textformfield.dart';
import 'package:flutter_application_2/components/my_button_new.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_2/services/firestore_register.dart';

class SuperUserPage extends StatefulWidget {
  SuperUserPage({super.key});

  @override
  State<SuperUserPage> createState() => _SuperUserPageState();
}

class _SuperUserPageState extends State<SuperUserPage> {
  final TextEditingController _userName_1 = TextEditingController();
  final TextEditingController _wardNo = TextEditingController();
  final TextEditingController _mobNo = TextEditingController();
  final TextEditingController _password_1 = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final TextEditingController _emailId = TextEditingController();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  final role = 'superuser';

  final FireStoreRegister fireStoreRegister = FireStoreRegister();

  Future registerSuperUser(BuildContext context) async {
    Loader.showLoadingDialog(context);
    // Just create a new user and password
    if (passwordConfirmed()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailId.text.trim(), password: _password_1.text.trim());

        // Add user details
        fireStoreRegister.addNormalUserDetails(
            _userName_1.text.trim(),
            _emailId.text.trim(),
            _wardNo.text.trim(),
            _mobNo.text.trim(),
            _password_1.text.trim(),
            role: role.trim());

        Navigator.of(context).pop();
      } catch (e) {
        // print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@${e.code}");
        // Navigator.of(context).pop();
      }
    }
    await FirebaseAuth.instance.signOut();
    Navigator.pop(context);
  }

  void _submitRegisterForm(BuildContext context) {
    if (formKey2.currentState!.validate()) {
      registerSuperUser(context);
    }
  }

  bool passwordConfirmed() {
    if (_password_1.text.trim() == _confirmPass.text.trim()) {
      return true;
    } else {
      return false;
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
      appBar: AppBar(
        title: const Text(
          'Admin Controls',
        ),
        centerTitle: true,
        // backgroundColor: AppPallete.barAppNav,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, 'adminlvl');
          },
        ),
      ),
      body: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 10),
              const Text(
                "Super User Creation!!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 0.5),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Text("Create an account for superuser"),
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
                  text: "Create Superuser"),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
