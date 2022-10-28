import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:horses_app/class/RegisterModel.dart';
import 'package:horses_app/config/mongodb.dart';
import 'package:horses_app/screens/Hall.dart';

import 'Nav.dart';

class Login extends StatefulWidget {

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String username = "";
  String email = "";
  String password = "";
  String newPassword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Login"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: TextField(
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
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  var query = await MongoDatabase.db.collection("users").findOne({"username": username, "password": password});

                  print(query);

                  if (query == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Wrong username or password"),
                      ),
                    );
                  } else {
                    MongoDatabase.getUserId(query['_id']);

                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Hall()), (Route<dynamic> route) => false);
                  }
                },
                child: const Text("Login"),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => {
                  Navigator.pushReplacementNamed(context, "/register"),
                },
                child: const Text("Register"),
              ),
              TextButton(
                onPressed: () => _dialogBuilder(context),
                child: const Text("I forgot my password"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reset my password'),
          content: SizedBox(
            width: 100,
            height: 350,
            child: Column(
              children: [
                const Text("In order to reset your password, please enter your email address and your username"),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                  child: TextField(
                    onChanged: (value) {
                      username = value;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                  child: TextField(
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                  child: TextField(
                    onChanged: (value) {
                      newPassword = value;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'New Password',
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Confirm'),
              onPressed: () async {
                var query = await MongoDatabase.db.collection("users").findOne({"username": username, "email": email});

                print(query);

                if (query == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Wrong username or email"),
                    ),
                  );
                } else {
                  MongoDatabase.db.collection("users").updateOne({
                    "username": username
                  }, {
                    "\$set": {
                      "password": newPassword,
                    }
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Password changed"),
                    ),
                  );

                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
