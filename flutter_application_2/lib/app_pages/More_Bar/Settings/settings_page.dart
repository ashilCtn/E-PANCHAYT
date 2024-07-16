import 'package:flutter/material.dart';
import 'package:flutter_application_2/core/theme/theme_notifier.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _selectedLanguage = 'English'; // Default language

  final List<String> _languages = ['English', 'മലയാളം']; // List of languages

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Settings'.tr),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text(
              'Dark Mode'.tr,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            trailing: Switch(
              value: themeNotifier.isDarkMode,
              onChanged: (value) {
                themeNotifier.toggleTheme();
              },
            ),
          ),
          const Divider(),
          ListTile(
            title: Text(
              'Language'.tr,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            trailing: DropdownButton<String>(
              value: _selectedLanguage,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLanguage = newValue!;
                  // Implement language change functionality here
                  if (newValue == 'English') {
                    var locale = const Locale('en', 'US');
                    Get.updateLocale(locale);
                  } else {
                    var locale = const Locale('ml', 'IN');
                    Get.updateLocale(locale);
                  }
                });
              },
              items: _languages.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          const Divider(),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'signout'),
            child: ListTile(
              title: Text(
                'Log Out'.tr,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
