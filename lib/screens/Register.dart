// ignore_for_file: file_names, avoid_print, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:horses_app/config/constants.dart';
import 'package:horses_app/config/mongodb.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../class/RegisterModel.dart';
// import 'package:flutter/services.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<Register> {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var photoController = TextEditingController();

  String username = '';
  String password = '';
  String email = '';
  String photo = '';
  bool isLogged = true;

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
                  controller: usernameController,
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
                  controller: emailController,
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
                  controller: passwordController,
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
                  controller: photoController,
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
                onPressed: () {
                  insert();

                  Navigator.pop(
                      context,
                      RegisterModel(
                        username: username,
                        password: password,
                        email: email,
                        photo: photo,
                        isLogged: isLogged,
                      ));
                },
                icon: const Icon(
                  Icons.save_alt_outlined,
                ),
                label: Container(
                    margin: const EdgeInsets.all(15),
                    child: const Text("Create Account")),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void insert() async {
    await MongoDatabase.insertUser(
        "users",
        RegisterModel(
          username: username,
          email: email,
          password: password,
          photo: photo,
          isLogged: isLogged,
        ));
  }
}
