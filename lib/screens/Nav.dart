import 'package:flutter/material.dart';

import 'Home.dart';
import 'Login.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NavBarState();
  }
}

int _currentIndex = 0;
final List pages = [Home(), Login()];

currentPage() {
  return pages[_currentIndex];
}

getPage() {
  return Login();
}

class _NavBarState extends State<NavBar> {
  var routes = ['/hall', '/account', '/horse'];
  var page = Home();

  void onTabTapped(int index) {
    setState(() {
      if (index == _currentIndex) {
        return;
      }

      _currentIndex = index;
      Navigator.pushNamed(context, routes[_currentIndex]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: onTabTapped,
      items: const [
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
    );
  }
}
