// ignore_for_file: file_names, avoid_print, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:horses_app/config/mongodb.dart';
import 'package:horses_app/screens/Hall.dart';
import 'package:horses_app/screens/Login.dart';

import '../class/RegisterModel.dart';
// import 'package:flutter/services.dart';

class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<Register> {
  // var usernameController = TextEditingController();
  // var passwordController = TextEditingController();
  // var emailController = TextEditingController();
  // var photoController = TextEditingController();

  String username = '';
  String password = '';
  String email = '';
  String photo = '';
  bool isLogged = true;
  int? age;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          // mainAxisAlignment: MainAxisAlignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Create your account",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: TextField(
                  // controller: usernameController,
                  onChanged: (value) {
                    username = value;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 300,
                child: TextField(
                  // controller: emailController,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 300,
                child: TextField(
                  // controller: passwordController,
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 300,
                child: TextField(
                  // controller: photoController,
                  onChanged: (value) {
                    photo = value;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Profile Picture',
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () async {
                  var queryUser = await MongoDatabase.db
                      .collection("users")
                      .find({"username": username}).toList();

                  var queryEmail = await MongoDatabase.db
                      .collection("users")
                      .find({"email": email}).toList();

                  if (username == '' ||
                      password == '' ||
                      email == '' ||
                      photo == '') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill all the fields'),
                      ),
                    );
                  } else if (queryUser.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Username already exists"),
                      ),
                    );
                  } else if (queryEmail.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Email already exists"),
                      ),
                    );
                  } else {
                    await MongoDatabase.db.collection("users").insertOne({
                      "username": username,
                      "password": password,
                      "email": email,
                      "photo": photo,
                      "age": age,
                    });
                    await MongoDatabase.insertUser(RegisterModel(
                        username: username,
                        password: password,
                        email: email,
                        photo: photo,
                        age: age));
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Hall()),
                        (Route<dynamic> route) => false);
                    clearInputs();
                  }
                },
                icon: const Icon(
                  Icons.save_alt_outlined,
                ),
                label: Container(
                    margin: const EdgeInsets.all(15),
                    child: const Text("Create Account")),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                      (Route<dynamic> route) => false)
                },
                child: const Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void clearInputs() {
    username = '';
    password = '';
    email = '';
    photo = '';
  }
}
