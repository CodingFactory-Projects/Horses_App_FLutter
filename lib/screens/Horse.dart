import 'dart:math';

import 'package:flutter/material.dart';
import '../class/HorseModel.dart';
import '../config/mongodb.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'Nav.dart';

class Horse extends StatefulWidget {
  const Horse({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HorseState();
  }
}

class _HorseState extends State<Horse> {
  List<HorseModel> _horses = [];
  List<String> _horsesNames = [];
  List<TextEditingController> controllers =
      List<TextEditingController>.generate(8, (i) => TextEditingController());

  // late HorseModel horse = HorseModel(M.ObjectId(), '', '', '', '', '', '', '');

  late String name;
  late String photo;
  late String age;
  late String dress;
  late String race;
  late String gender;
  late String speciality;

  @override
  void initState() {
    super.initState();
    // getHorses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Chevaux'),
        ),
        body: SafeArea(
            child: FutureBuilder(
          future: MongoDatabase.getHorses(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasData) {
                var data = snapshot.data;
                return SingleChildScrollView(
                    child: Column(children: [
                  for (var i = 0; i < data.length; i++)
                    Card(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(data[i]["name"]),
                            Text(data[i]["photo"]),
                            Text(data[i]["age"]),
                            Text(data[i]["dress"]),
                            Text(data[i]["race"]),
                            Text(data[i]["gender"]),
                            Text(data[i]["speciality"]),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit_note),
                          color: Colors.black,
                          onPressed: () => {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Basic dialog title'),
                                    content: SingleChildScrollView(
                                      child: ListBody(children: [
                                        Column(
                                          children: [
                                            TextFormField(
                                              onChanged: (value) {
                                                data[i]["name"] = value;
                                              },
                                              initialValue: data[i]["name"],
                                              decoration: const InputDecoration(
                                                  labelText: 'Nom'),
                                            ),
                                            TextFormField(
                                              onChanged: (value) {
                                                data[i]["photo"] = value;
                                              },
                                              initialValue: data[i]["photo"],
                                              decoration: const InputDecoration(
                                                  labelText: 'Photo'),
                                            ),
                                            TextFormField(
                                              onChanged: (value) {
                                                data[i]["age"] = value;
                                              },
                                              initialValue: data[i]["age"],
                                              decoration: const InputDecoration(
                                                  labelText: 'Age'),
                                            ),
                                            TextFormField(
                                              onChanged: (value) {
                                                data[i]["dress"] = value;
                                              },
                                              initialValue: data[i]["dress"],
                                              decoration: const InputDecoration(
                                                  labelText: 'Robe'),
                                            ),
                                            TextFormField(
                                              onChanged: (value) {
                                                data[i]["race"] = value;
                                              },
                                              initialValue: data[i]["race"],
                                              decoration: const InputDecoration(
                                                  labelText: "Race"),
                                            ),
                                            TextFormField(
                                              onChanged: (value) {
                                                data[i]["gender"] = value;
                                              },
                                              initialValue: data[i]["gender"],
                                              decoration: const InputDecoration(
                                                  labelText: "Gender"),
                                            ),
                                            TextFormField(
                                              onChanged: (value) {
                                                data[i]["speciality"] = value;
                                              },
                                              initialValue: data[i]
                                                  ["speciality"],
                                              decoration: const InputDecoration(
                                                  labelText: "Speciality"),
                                            ),
                                          ],
                                        )
                                      ]),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                          style: TextButton.styleFrom(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                          ),
                                          child: const Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          }),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                        child: const Text('Confirm'),
                                        onPressed: () async {
                                          await MongoDatabase.updateHorse(
                                              data[i]["_id"],
                                              data[i]["name"],
                                              data[i]["photo"],
                                              data[i]["age"],
                                              data[i]["dress"],
                                              data[i]["race"],
                                              data[i]["gender"],
                                              data[i]["speciality"]).whenComplete(() => Navigator.of(context).pop());
                                          setState(() {

                                          });
                                        },
                                      ),
                                    ],
                                  );
                                })
                          },
                        ),
                      ],
                    ))
                ]));
              } else {
                return const Center(child: Text("No data"));
              }
            }
          },
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showDialog();
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add,
              color: Colors.white, size: 30.0, semanticLabel: 'Add'),
        ),
        bottomNavigationBar: const NavBar());
  }

  Future<void> _showDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Ajouter un cheval'),
            content: SingleChildScrollView(
                child: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    name = value;
                  },
                  decoration:
                      const InputDecoration(labelText: 'Nom', hintText: 'Nom'),
                ),
                TextField(
                  onChanged: (value) {
                    photo = value;
                  },
                  decoration: const InputDecoration(
                      labelText: 'Photo', hintText: 'Photo'),
                ),
                TextField(
                  onChanged: (value) {
                    age = value;
                  },
                  decoration:
                      const InputDecoration(labelText: 'Age', hintText: 'Age'),
                ),
                TextField(
                  onChanged: (value) {
                    dress = value;
                  },
                  decoration: const InputDecoration(
                      labelText: 'Robe', hintText: 'Robe'),
                ),
                TextField(
                    onChanged: (value) {
                      race = value;
                    },
                    decoration: const InputDecoration(
                        labelText: 'Race', hintText: 'Race')),
                TextField(
                    onChanged: (value) {
                      gender = value;
                    },
                    decoration: const InputDecoration(
                        labelText: 'Gender', hintText: 'Gender')),
                TextField(
                    onChanged: (value) {
                      speciality = value;
                    },
                    decoration: const InputDecoration(
                        labelText: 'Race', hintText: 'Race')),
              ],
            )),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Cancel'),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Confirmer'),
                onPressed: () async {
                  var _id = M.ObjectId();
                  if(name == "" || photo == "" || age == "" || dress == "" || race == ""|| gender == ""|| speciality == ""){
                    return;
                  }else{
                    var query =
                    await MongoDatabase.db.collection("horses").insertOne({
                      "_id": _id,
                      "_ownerId" : MongoDatabase.idUser,
                      "name": name,
                      "photo": photo,
                      "age": age,
                      "dress": dress,
                      "race": race,
                      "gender": gender,
                      "speciality": speciality,
                    }).whenComplete(() {
                      Navigator.of(context).pop();
                    });
                    setState(() {
                      name = "";
                      photo = "";
                      age = "";
                      dress = "";
                      race = "";
                      gender = "";
                      speciality = "";
                    });
                  }

                },
              ),
            ],
          );
        });
  }

  //
  // addHorse() async {
  //   var _id = M.ObjectId();
  //   HorseModel horse = HorseModel(
  //       _id, 'Horse${Random().nextInt(10000)}', '', '', '', '', '', '');
  //
  //   horse.id = await MongoDatabase.addHorse(horse);
  //   _horses.add(horse);
  //
  //   setState(() {
  //     _horses = _horses;
  //     _horsesNames.add(horse.name!);
  //   });
  // }
  //
  // deleteHorse() async {
  //   await MongoDatabase.deleteHorse(horse.name);
  // }
}
