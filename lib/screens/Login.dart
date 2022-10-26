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
  List<String> list = <String>['Oui', 'Non',];
  String dropdownValue = 'Oui';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Login"),
      ),
      bottomNavigationBar: const NavBar(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                  hintText: 'Numéro de téléphone'
              ),
              onChanged: (value) {

              },
            ),
            TextField(
              decoration: const InputDecoration(
                  hintText: 'Âge'
              ),
              onChanged: (value) {
              },
            ),
            TextField(
              decoration: const InputDecoration(
                  hintText: 'Profil FFE'
              ),
              onChanged: (value) {
              },
            ),
            TextButton(
                onPressed: () {

                },
                child: const Text('Mettre à jour mon profil')
            ),
            const Text("DP ?"),
            DropdownButton<String>(
              value: dropdownValue,
              style: const TextStyle(color: Colors.deepPurple),
              onChanged: (String? value) {
                setState(() {
                  dropdownValue = value!;
                  print(dropdownValue);
                });
              },
              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
