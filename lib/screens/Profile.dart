import 'package:flutter/material.dart';

import '../class/UserModel.dart';
import '../config/mongodb.dart';
import 'Nav.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> {
  UserModel user = UserModel('', '', '', '', '', '', '', '');
  List<TextEditingController> controllers =
      List<TextEditingController>.generate(3, (i) => TextEditingController());

  //List<String> list = <String>['Oui', 'Non',];
  //String dropdownValue = 'Non';

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Profile'),
      ),
      bottomNavigationBar: const NavBar(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TextField(
              controller: controllers[0],
              decoration:
                  const InputDecoration(hintText: 'Numéro de téléphone'),
              onChanged: (value) {
                user.phoneNumber = value;
              },
            ),
            TextField(
              controller: controllers[1],
              decoration: const InputDecoration(hintText: 'Âge'),
              onChanged: (value) {
                user.age = value;
              },
            ),
            TextField(
              controller: controllers[2],
              decoration: const InputDecoration(hintText: 'Profil FFE'),
              onChanged: (value) {
                user.ffeLink = value;
              },
            ),
            const Text("Demi pension ?"),
            ListTile(
              title: const Text("Oui"),
              leading: Radio(
                value: 'Oui',
                groupValue: user.dp,
                onChanged: (value) {
                  setState(() {
                    user.dp = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text("Non"),
              leading: Radio(
                value: 'Non',
                groupValue: user.dp,
                onChanged: (value) {
                  setState(() {
                    user.dp = value;
                  });
                },
              ),
            ),
            TextButton(
                onPressed: () {
                  // _updateProfile();
                },
                child: const Text('Mettre à jour mon profil')),
          ],
        ),
      ),
    );
  }

  void _getProfile() async {
    final profile = await MongoDatabase.select('users');

    user.username = profile['username'];
    user.email = profile['email'];
    user.username = profile['username'];
    user.profilePicture = profile['image'];

    controllers[0].text = user.phoneNumber!;
    controllers[1].text = user.age!;
    controllers[2].text = user.ffeLink!;

    setState(() {
      user = user;
    });
  }

  // _updateProfile() async {
  //   await MongoDatabase.updateUser(user);
  // }
}
