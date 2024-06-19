import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/core/RBAC/role_retrieve.dart';
import 'package:flutter_application_2/core/theme/app_pallete.dart';
import 'package:flutter_application_2/core/theme/theme.dart';
import 'package:flutter_application_2/services/firestore_register.dart'; // Make sure to import your AppTheme

class MoreMainPage extends StatefulWidget {
  const MoreMainPage({super.key, Key? key2});

  @override
  State<MoreMainPage> createState() => _MoreMainPageState();
}

class _MoreMainPageState extends State<MoreMainPage> {
  String role = '';
  FireStoreRegister fireStoreRegister = FireStoreRegister();
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    getUserRole();
  }

  Future<void> getUserRole() async {
    AccessRole accessRole = AccessRole();
    String retrievedRole = await accessRole.getUserRole();
    if (mounted) {
      setState(() {
        role = retrievedRole;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, 'z');
          },
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Image.asset(
                isDarkMode
                    ? 'lib/img/white_logo.png'
                    : 'lib/img/black_logo.png',
                height: 150,
                width: 150,
              ),
              const SizedBox(height: 10),
              const Divider(
                color: AppPallete.lightGreyColor,
              ),
              _buildCard(context, 'person_pin', 'Profile', 'profile'),
              const SizedBox(height: 10),
              if (role == 'admin')
                _buildCard(context, 'admin_panel_settings', 'Admin Controls',
                    'adminlvl'),
              if (role == 'admin') const SizedBox(height: 10),
              _buildCard(context, 'contacts_rounded', 'Contacts', 'contact'),
              const SizedBox(height: 10),
              _buildCard(context, 'settings', 'Settings', 'settings'),
              const SizedBox(height: 10),
              _buildCard(context, 'question_mark_rounded', 'About', 'about'),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  // Function to get IconData based on iconName
  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'person_pin':
        return Icons.person_pin;
      case 'admin_panel_settings':
        return Icons.admin_panel_settings;
      case 'contacts_rounded':
        return Icons.contacts_rounded;
      case 'settings':
        return Icons.settings;
      case 'question_mark_rounded':
        return Icons.question_mark_rounded;
      default:
        return Icons.error;
    }
  }

  Widget _buildCard(BuildContext context, String iconName, String displayText,
      String nextPage) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    IconData iconData = _getIconData(iconName);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(20),
        gradient: isDarkMode
            ? AppTheme.darkThemeGradient
            : AppTheme.lightThemeGradient,
      ),
      child: ListTile(
        leading: Icon(iconData),
        title: Text(displayText),
        onTap: () {
          Navigator.pushNamed(context, nextPage);
        },
      ),
    );
  }
}
