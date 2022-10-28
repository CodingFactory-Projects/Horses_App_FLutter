import 'package:flutter/material.dart';
import 'package:horses_app/config/mongodb.dart';
import 'package:horses_app/screens/Nav.dart';

class Account extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AccountState();
  }
}

class _AccountState extends State<Account> {
  bool isEnabled = false;
  String? phoneNumber;
  String? age;
  String? profileFFE;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Hall"),
      ),
      bottomNavigationBar: const NavBar(),
      body: SafeArea(
        child: FutureBuilder(
            future: MongoDatabase.getUserById(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.hasData) {
                  var data = snapshot.data;

                  return SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          Image.network(
                            data[0]['photo'],
                            // width: 200,
                            // height: 200,
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                TextFormField(
                                  initialValue: data[0]['username'],
                                  enabled: false,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Username',
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  initialValue: data[0]['email'],
                                  enabled: false,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Email',
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  initialValue: data[0]['photo'],
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) =>
                                      {data[0]['photo'] = value},
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Profile Picture',
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  initialValue: data[0]['age'],
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) => {age = value},
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Age',
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  initialValue: data[0]['phoneNumber'],
                                  onChanged: (value) => {phoneNumber = value},
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Phone Number',
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  initialValue: data[0]['profilFFE'],
                                  onChanged: (value) => {profileFFE = value},
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Profil FFE',
                                  ),
                                ),
                                ElevatedButton(
                                    style: TextButton.styleFrom(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    ),
                                    child: const Text('Confirm'),
                                    onPressed: () async {
                                      await MongoDatabase.updateUser(
                                              data[0]['_id'],
                                              data[0]['photo'],
                                              age,
                                              phoneNumber,
                                              profileFFE)
                                          .whenComplete(() => {
                                                Navigator.of(context).pop(),
                                              });
                                      // setState(() {});
                                    }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  Navigator.pushNamed(context, "/home");
                  return const Center(
                    child: Text("No data available"),
                  );
                }
              }
            }),
      ),
    );
  }
}
