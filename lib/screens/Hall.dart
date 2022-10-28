import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:horses_app/class/RegisterModel.dart';
import 'package:horses_app/config/mongodb.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'Nav.dart';

class Hall extends StatefulWidget {
  Hall({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HallState();
  }
}

class _HallState extends State<Hall> {
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

                  return Column(
                    children: [
                      Center(
                          child: Column(
                        children: [
                          Text("Welcome ${data[0]['username']}"),
                          SizedBox(
                            height: 300,
                            child: Card(
                                child:
                                    Image.network(data[0]['photo'].toString())),
                          ),
                          ElevatedButton(
                              onPressed: () => {
                                MongoDatabase.getUserId(""),
                                Navigator.pushNamed(
                                    context, "/login"),
                              },
                              child: const Text("Logout")),

                        ],
                      )),
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
