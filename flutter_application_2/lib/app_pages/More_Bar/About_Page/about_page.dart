import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  PackageInfo? _packageInfo; // Declare _packageInfo as nullable

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = packageInfo; // Assign fetched packageInfo to _packageInfo
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('About'),
      ),
      body: Column(
        children: [
          Image.asset(
            isDarkMode ? 'lib/img/white_logo.png' : 'lib/img/black_logo.png',
            height: 150,
            width: 150,
          ),
          const SizedBox(height: 10),
          const Divider(
            color: Colors.grey,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Welcome to E-Panchayat, your digital gateway to local governance. Empowering communities through technology, our app facilitates seamless interaction between citizens and panchayat officials. From accessing services and information to participating in decision-making, E-Panchayat bridges the gap for a more connected and efficient local administration. Join us in building stronger, smarter communities, one tap at a time.",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 15),
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          if (_packageInfo != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListTile(
                title: const Text(
                  'Version',
                  style: TextStyle(fontSize: 18),
                ),
                subtitle: Text(
                  _packageInfo!.version,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            )
          else
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
