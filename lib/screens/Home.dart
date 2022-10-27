import 'package:flutter/material.dart';

import 'Nav.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: const NavBar(),
      body: const Center(
        child: Text('Home'),
      ),
    );
  }
}
