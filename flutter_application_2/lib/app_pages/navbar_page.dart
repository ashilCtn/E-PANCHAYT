import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/app_pages/more_page.dart';
import 'package:flutter_application_2/app_pages/service_page.dart';
import 'package:flutter_application_2/app_pages/updates_page.dart';
import 'package:flutter_application_2/core/theme/app_pallete.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class FunPage extends StatefulWidget {
  const FunPage({super.key});

  @override
  State<FunPage> createState() => _FunPageState();
}

class _FunPageState extends State<FunPage> {
  final List<Widget> _pages = [
    ServicePage(),
    const UpdatesPage(),
    const MoreMainPage(),
    // ProfilePage()
  ];
  int _selectedIndex =
      1; // Set the default index to the index of the Updates page

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: AppPallete.barAppNav,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            backgroundColor: AppPallete.barAppNav,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: const Color.fromARGB(178, 43, 43, 43),
            gap: 8,
            selectedIndex: _selectedIndex, // Set the selected index here
            onTabChange: _navigateBottomBar,
            padding: const EdgeInsets.all(16),
            tabs: [
              GButton(
                icon: Icons.miscellaneous_services_outlined,
                text: 'Services',
                active: _selectedIndex == 0,
              ),
              GButton(
                icon: Icons.update,
                text: 'Updates',
                active: _selectedIndex == 1,
              ),
              GButton(
                icon: CupertinoIcons.ellipsis,
                text: 'More',
                active: _selectedIndex == 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
