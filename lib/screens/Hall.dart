import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:horses_app/class/RegisterModel.dart';
import 'package:horses_app/config/mongodb.dart';

class Hall extends StatefulWidget {
  Hall({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HallState();
  }
}

class _HallState extends State<Hall> {
  bool isEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Hall"),
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: MongoDatabase.getUserById(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.hasData) {
                  var data = snapshot.data;

                  return Column(
                    children: [
                      Row(
                        children: [
                          Center(
                            child: ElevatedButton.icon(
                                onPressed: () => {
                                      showDialog<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            contentPadding: EdgeInsets.zero,
                                            title: const Center(
                                              child: Text('My Profile Details'),
                                            ),
                                            content: SingleChildScrollView(
                                              child: SizedBox(
                                                width: 350,
                                                // height: 450,
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
                                                            decoration: const InputDecoration(
                                                              border: OutlineInputBorder(),
                                                              labelText: 'Username',
                                                            ),
                                                          ),
                                                          const SizedBox(height: 20),
                                                          TextFormField(
                                                            initialValue: data[0]['email'],
                                                            decoration: const InputDecoration(
                                                              border: OutlineInputBorder(),
                                                              labelText: 'Email',
                                                            ),
                                                          ),
                                                          const SizedBox(height: 20),
                                                          TextFormField(
                                                            initialValue: data[0]['age'],
                                                            decoration: const InputDecoration(
                                                              border: OutlineInputBorder(),
                                                              labelText: 'Age',
                                                            ),
                                                          ),
                                                          const SizedBox(height: 20),
                                                          TextFormField(
                                                            initialValue: data[0]['phoneNumber'],
                                                            onChanged: (value) => {
                                                              setState(() {
                                                                username = value;
                                                              })
                                                            },
                                                            decoration: const InputDecoration(
                                                              border: OutlineInputBorder(),
                                                              labelText: 'Phone Number',
                                                            ),
                                                          ),
                                                          const SizedBox(height: 20),
                                                          TextFormField(
                                                            initialValue: data[0]['profilFFE'],
                                                            decoration: const InputDecoration(
                                                              border: OutlineInputBorder(),
                                                              labelText: 'Profil FFE',
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
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
                                                    Navigator.of(context).pop();
                                                  }),
                                            ],
                                          );
                                        },
                                      )
                                    },
                                icon: const Icon(Icons.person_outline_outlined),
                                label: const Text("My Profile")),
                          ),
                        ],
                      ),
                      Text("Welcome ${data[0]['username']}"),
                      SizedBox(
                        height: 300,
                        child: Card(child: Image.network(data[0]['photo'].toString())),
                      ),
                      ElevatedButton(
                          onPressed: () => {
                                MongoDatabase.getUserId(""),
                                Navigator.pushNamed(context, "/login"),
                              },
                          child: const Text("Logout")),
                    ],
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
