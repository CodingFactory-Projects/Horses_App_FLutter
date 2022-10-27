// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:horses_app/screens/Register.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  var loggedUser = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Welcome to HorsesApp",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
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
                  _navigateAndDisplaySelection(context);
                },
                child: const Text("Register",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                  _navigateAndDisplaySelection(context);
                },
                child: const Text("Login",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            )
          ],
        ),
      )),
    );
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Register()),
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result')));

    setState(() {
      loggedUser.add(result);
      print(result);
      // data = result;
    });
  }
}
