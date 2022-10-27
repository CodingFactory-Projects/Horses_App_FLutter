import 'package:flutter/material.dart';
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
  String username = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hall"),
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: MongoDatabase.getData("users"),
            builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData) {
              var totalData = snapshot.data.length;
              print("Total Data : ${totalData.toString()}");
              return ListView.builder(itemCount: snapshot.data.length,itemBuilder: (context, index){
                return displayCard(RegisterModel.fromJson(snapshot.data[index]));
              });
            } else {
              return const Center(
                child: Text("No data available"),
              );
            }
          }
        }),
      ),
    );
  }

  Widget displayCard(RegisterModel data){
    return Card(
      child: Column(
        children: [
          Text(data.username),
          const SizedBox(height: 10),
          Text(data.email),
          const SizedBox(height: 10),
          Text(data.password),
          const SizedBox(height: 10),
          Text(data.photo),
        ],
      ),
    );
  }
}
