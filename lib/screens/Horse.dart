// ignore_for_file: library_prefixes

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

import '../config/mongodb.dart';

class Horse extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HorseState();
  }
}

class _HorseState extends State<Horse> {
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
          child: Center(
        child: FutureBuilder(
          future: MongoDatabase.getHorses(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasData) {
                var data = snapshot.data;
                return SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      for (var i = 0; i < data.length; i++)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              minHeight: 100,
                              minWidth: 100,
                              maxWidth: 308,
                            ),
                            child: Card(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                ),
                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(10.0),
                                              topLeft: Radius.circular(10.0)),
                                          //add border radius
                                          child: Image.network(
                                            data[i]['photo'],
                                            height: 200.0,
                                            width: 300.0,
                                            fit: BoxFit.cover,
                                            errorBuilder: (BuildContext context, Object exception,
                                                StackTrace? stackTrace) {
                                              return Column(
                                                children: [
                                                  Image.asset('lib/assets/images/invalid_horse.png',
                                                      height: 200.0, width: 300.0, fit: BoxFit.cover),
                                                  Text('Your image is not available',
                                                      style: GoogleFonts.poppins(
                                                          color: Colors.red,
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.bold),
                                                      textAlign: TextAlign.center),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Text('Nom : ',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    color: Colors.black38)),
                                            Text(data[i]['name'],
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.normal, fontSize: 16)),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Age : ',
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  color: Colors.black38),
                                            ),
                                            Text(data[i]['age'], style: GoogleFonts.poppins(fontSize: 16)),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text('Robe : ',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    color: Colors.black38)),
                                            Text(data[i]['dress'], style: GoogleFonts.poppins(fontSize: 16)),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text('Robe : ',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    color: Colors.black38)),
                                            Text(data[i]["race"], style: GoogleFonts.poppins(fontSize: 16)),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text('Genre : ',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    color: Colors.black38)),
                                            Text(data[i]["gender"], style: GoogleFonts.poppins(fontSize: 16)),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text('Speciality : ',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    color: Colors.black38)),
                                            Text(data[i]["speciality"],
                                                style: GoogleFonts.poppins(fontSize: 16)),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.edit_note),
                                              color: const Color(0xFF2596be),
                                              hoverColor: const Color(0xD9A9A9A),
                                              onPressed: () => {
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text("Update the horse : ${data[i]['name']}"),
                                                        content: SingleChildScrollView(
                                                          child: ListBody(children: [
                                                            SizedBox(
                                                              width: 300,
                                                              child: Column(
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
                                                                    initialValue: data[i]["speciality"],
                                                                    decoration: const InputDecoration(
                                                                        labelText: "Speciality"),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ]),
                                                        ),
                                                        actions: <Widget>[
                                                          TextButton(
                                                              style: TextButton.styleFrom(
                                                                textStyle:
                                                                    Theme.of(context).textTheme.labelLarge,
                                                              ),
                                                              child: const Text('Cancel'),
                                                              onPressed: () {
                                                                Navigator.of(context).pop();
                                                              }),
                                                          TextButton(
                                                            style: TextButton.styleFrom(
                                                              textStyle:
                                                                  Theme.of(context).textTheme.labelLarge,
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
                                                                      data[i]["speciality"])
                                                                  .whenComplete(() => setState(() {
                                                                        Navigator.of(context).pop();
                                                                      }));
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    })
                                              },
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.delete),
                                              color: const Color(0xFF2596be),
                                              hoverColor: const Color(0xD9A9A9A),
                                              onPressed: () async {
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text('Delete horse'),
                                                        content: SingleChildScrollView(
                                                          child: ListBody(
                                                            children: const <Widget>[
                                                              Text(
                                                                  'Are you sure you want to delete this horse ?'),
                                                            ],
                                                          ),
                                                        ),
                                                        actions: <Widget>[
                                                          ClipRRect(
                                                            borderRadius: BorderRadius.circular(4),
                                                            child: Stack(
                                                              children: <Widget>[
                                                                Positioned.fill(
                                                                  child: Container(
                                                                    decoration: const BoxDecoration(
                                                                      color: Color(0xffffffff),
                                                                    ),
                                                                  ),
                                                                ),
                                                                TextButton(
                                                                  style: TextButton.styleFrom(
                                                                    foregroundColor: Colors.white,
                                                                    padding: const EdgeInsets.all(16.0),
                                                                    textStyle: const TextStyle(fontSize: 16),
                                                                  ),
                                                                  onPressed: () async {
                                                                    Navigator.of(context).pop();
                                                                  },
                                                                  child: const Text('Cancel',
                                                                      style: TextStyle(
                                                                          color: Colors.black,
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.w600)),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          ClipRRect(
                                                            borderRadius: BorderRadius.circular(4),
                                                            child: Stack(
                                                              children: <Widget>[
                                                                Positioned.fill(
                                                                  child: Container(
                                                                    decoration: const BoxDecoration(
                                                                      color: Color(0xffBE2525),
                                                                    ),
                                                                  ),
                                                                ),
                                                                TextButton(
                                                                  style: TextButton.styleFrom(
                                                                    foregroundColor: Colors.white,
                                                                    padding: const EdgeInsets.all(16.0),
                                                                    textStyle: const TextStyle(fontSize: 16),
                                                                  ),
                                                                  onPressed: () async {
                                                                    deleteHorse(data[i]["_id"]);
                                                                    Navigator.of(context).pop();
                                                                    setState(() {});
                                                                  },
                                                                  child: const Text('Delete',
                                                                      style: TextStyle(
                                                                          color: Colors.white,
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.w700)),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    });
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ),
                        )
                    ]));
              } else {
                return const Center(child: Text("No data"));
              }
            }
          },
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog();
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white, size: 30.0, semanticLabel: 'Add'),
      ),
    );
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
                      const InputDecoration(labelText: 'Nom', hintText: 'Nom', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 10),
                TextField(
                  onChanged: (value) {
                    photo = value;
                  },
                  decoration: const InputDecoration(
                      labelText: 'Photo', hintText: 'Photo', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 10),
                TextField(
                  onChanged: (value) {
                    age = value;
                  },
                  decoration:
                      const InputDecoration(labelText: 'Age', hintText: 'Age', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 10),
                TextField(
                  onChanged: (value) {
                    dress = value;
                  },
                  decoration: const InputDecoration(
                      labelText: 'Robe', hintText: 'Robe', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 10),
                TextField(
                    onChanged: (value) {
                      race = value;
                    },
                    decoration: const InputDecoration(
                        labelText: 'Race', hintText: 'Race', border: OutlineInputBorder())),
                const SizedBox(height: 10),
                TextField(
                    onChanged: (value) {
                      gender = value;
                    },
                    decoration: const InputDecoration(
                        labelText: 'Gender', hintText: 'Gender', border: OutlineInputBorder())),
                const SizedBox(height: 10),
                TextField(
                    onChanged: (value) {
                      speciality = value;
                    },
                    decoration: const InputDecoration(
                        labelText: 'Speciality', hintText: 'Speciality', border: OutlineInputBorder())),
              ],
            )),
            actions: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(16.0),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      onPressed: () async {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel',
                          style:
                              TextStyle(color: Color(0xFF2596be), fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                onPressed: () async {
                  var id = M.ObjectId();
                  if (name == "" ||
                      photo == "" ||
                      age == "" ||
                      dress == "" ||
                      race == "" ||
                      gender == "" ||
                      speciality == "") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please fill all the fields"),
                      ),
                    );
                  } else {
                    await MongoDatabase.db.collection("horses").insertOne({
                      "_id": id,
                      "_ownerId": MongoDatabase.idUser,
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
                child: const Text('Confirmer',
                    style: TextStyle(color: Color(0xff6dc55c), fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ],
          );
        });
  }

  void deleteHorse(M.ObjectId id) async {
    await MongoDatabase.db.collection("horses").deleteOne({"_id": id});
  }
}
