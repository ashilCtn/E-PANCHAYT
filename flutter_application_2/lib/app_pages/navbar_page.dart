import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/app_pages/More_Bar/more_page.dart';
import 'package:flutter_application_2/app_pages/Services_Bar/service_page.dart';
import 'package:flutter_application_2/app_pages/Updates_Bar/updates_page.dart';
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
    // Access the current theme
    final theme = Theme.of(context);
    final bottomNavBarTheme = theme.bottomNavigationBarTheme;

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        color:
            bottomNavBarTheme.backgroundColor, // Set the background color here
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
          child: GNav(
            color: bottomNavBarTheme.unselectedItemColor,
            activeColor: bottomNavBarTheme.selectedItemColor,
            tabBackgroundColor: theme.colorScheme.secondary.withOpacity(0.2),
            gap: 8,
            selectedIndex: _selectedIndex, // Set the selected index here
            onTabChange: _navigateBottomBar,
            padding: const EdgeInsets.all(16),
            tabs: [
              GButton(
                icon: Icons.miscellaneous_services_outlined,
                text: 'Services',
                textStyle: theme.textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.w800),
                iconColor: bottomNavBarTheme.unselectedItemColor,
                iconActiveColor: bottomNavBarTheme.selectedItemColor,
                active: _selectedIndex == 0,
              ),
              GButton(
                icon: Icons.update,
                text: 'Updates',
                textStyle: theme.textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.w800),
                iconColor: bottomNavBarTheme.unselectedItemColor,
                iconActiveColor: bottomNavBarTheme.selectedItemColor,
                active: _selectedIndex == 1,
              ),
              GButton(
                icon: CupertinoIcons.ellipsis,
                text: 'More',
                textStyle: theme.textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.w800),
                iconColor: bottomNavBarTheme.unselectedItemColor,
                iconActiveColor: bottomNavBarTheme.selectedItemColor,
                active: _selectedIndex == 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
