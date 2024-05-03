import 'package:flutter/material.dart';
import 'package:flutter_application_2/app_pages/profile_page.dart';
import 'package:flutter_application_2/app_pages/service_page1.dart';
import 'package:flutter_application_2/app_pages/updates_page.dart';

class FunPage extends StatefulWidget {
  const FunPage({super.key});

  @override
  State<FunPage> createState() => _FunPageState();
}

class _FunPageState extends State<FunPage> {
  final List _pages = [ServicePage(), const UpdatesPage(), ProfilePage()];
  int _selectedIndex = 0;
  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        backgroundColor: Colors.grey[300],
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.miscellaneous_services_outlined,
                color: Colors.black,
              ),
              label: "Services"),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.update,
              color: Colors.black,
            ),
            label: "Updates",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle_rounded,
                color: Colors.black,
              ),
              label: "Profile"),
        ],
      ),
    );
  }
}
