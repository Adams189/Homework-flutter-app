import 'package:flutter/material.dart';
import 'package:homework/screens/bottom_navigation_screens/profile_screen.dart';
import '../bottom_navigation_screens/categories_screen.dart';
import '../bottom_navigation_screens/deals_screen.dart';
import '../bottom_navigation_screens/home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcomeRoute';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _currentIndex=0;
  List _screens=[HomeScreen(),DealScreen(),CategoriesScreen(),ProfileScreen(),];

  void _updateIndex(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: _updateIndex,
          selectedItemColor: Colors.blue[700],
          selectedFontSize: 15,
          unselectedFontSize: 13,
          iconSize: 30,
          items: const [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home),

            ),
            BottomNavigationBarItem(
              label: "Deals",
              icon: Icon(Icons.add_business),
            ),
            BottomNavigationBarItem(
              label: "Categories",
              icon: Icon(Icons.grid_view),
            ),
            BottomNavigationBarItem(
              label: "Profile",
              icon: Icon(Icons.account_circle_outlined),
            ),
          ],
        )
    );
  }
}


