import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<Register> {
  void test() {
    setState(() {
      print("test");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          // mainAxisAlignment: MainAxisAlignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(
                  width: 300,
                  child: TextField(
                    // obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                    // obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}
