import 'package:flutter/material.dart';
import 'package:horses_app/screens/Account.dart';
import 'package:horses_app/screens/Hall.dart';
import 'package:horses_app/screens/Horse.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NavBarState();
  }
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final screens = [
    Hall(),
    Account(),
    Horse(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Compte',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Chevaux',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: const Color(0xFF2596be),
      onTap: _onItemTapped,

    );
  }
}
