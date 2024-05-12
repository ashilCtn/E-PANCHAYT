import 'package:flutter/material.dart';
import 'package:flutter_application_2/app_pages/More_Bar/about_page.dart';

class MoreMainPage extends StatefulWidget {
  const MoreMainPage({super.key, Key? key2});

  @override
  State<MoreMainPage> createState() => _MoreMainPageState();
}

class _MoreMainPageState extends State<MoreMainPage> {
  @override
  Widget build(BuildContext context) {
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
        // backgroundColor: const Color.fromARGB(188, 0, 0, 0),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          // color: Colors.white, // Background color of the container
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Card(
                child: ListTile(
                  title: const Text('Profile'),
                  onTap: () {
                    // Add your action here when Profile is tapped
                    // print('Profile tapped');
                    Navigator.pushNamed(context, 'profile');
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('Contacts'),
                  onTap: () {
                    // Add your action here when Contacts is tapped
                    // print('Contacts tapped');
                    Navigator.pushNamed(context, 'contact');
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('Settings'),
                  onTap: () {
                    // Add your action here when Sign Out is tapped
                    Navigator.pushNamed(context, 'settings');
                  },
                ),
              ),
              // Card(
              //   child: ListTile(
              //     title: const Text('Sign Out'),
              //     onTap: () {
              //       // Add your action here when Sign Out is tapped
              //       Navigator.pushNamed(context, 'signout');
              //     },
              //   ),
              // ),
              Card(
                child: ListTile(
                  title: const Text('About'),
                  onTap: () {
                    // Add your action here when About is tapped
                    // print('About tapped');
                    // Navigator.pushNamed(context, 'about');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AboutPage()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
