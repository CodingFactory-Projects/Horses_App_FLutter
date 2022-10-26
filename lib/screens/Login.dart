import 'package:flutter/material.dart';

import 'Nav.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Login"),
      ),
      bottomNavigationBar: const NavBar(),
      body: const Center(
        child: Text("Login"),
      ),
    );
  }
}
