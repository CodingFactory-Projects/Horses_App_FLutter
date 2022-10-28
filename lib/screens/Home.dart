// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:horses_app/class/RegisterModel.dart';
import 'package:horses_app/screens/Hall.dart';
import 'package:horses_app/screens/Register.dart';

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
      bottomNavigationBar: const NavBar(),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                const Text("Welcome to HorsesApp", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.grey,
                      backgroundColor: const Color(0xFF2596be),
                      elevation: 5,
                    ),
                    onPressed: () {
                      // Navigator.pop(context);
                      Navigator.pushNamed(context, '/register');
                    },
                    child: const Text("Register", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 150.0,
                  height: 50.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.grey,
                      backgroundColor: const Color(0xFF2596be),
                      elevation: 5,
                    ),
                    onPressed: () {
                      // Navigator.pop(context);
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text("Login",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
