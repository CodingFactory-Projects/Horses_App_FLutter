import 'dart:math';

import 'package:flutter/material.dart';

import '../class/HorseModel.dart';
import '../config/mongodb.dart';
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

  late HorseModel horse = HorseModel('', '', '', '', '', '', '');

  @override
  void initState() {
    super.initState();
    getHorses();
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
          child: Column(
            children: [
              const Text(
                'Liste de vos chevaux',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              DropdownButton(
                value: horse.name,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: _horsesNames.map((String horse) {
                  return DropdownMenuItem(
                    value: horse,
                    child: Text(horse),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  for (HorseModel horse in _horses) {
                    if (horse.name == newValue) {
                      horse = horse;
                    }
                  }

                  horse.name = newValue!;

                  controllers[0].text = horse.name!;
                  controllers[1].text = horse.photo!;
                  controllers[2].text = horse.age!;
                  controllers[3].text = horse.dress!;
                  controllers[4].text = horse.race!;
                  controllers[5].text = horse.gender!;
                  controllers[6].text = horse.speciality!;

                  setState(() {
                    horse = horse;
                    controllers = controllers;
                  });
                },
              ),
              IconButton(
                onPressed: () {
                  addHorse();
                },
                icon: const Icon(Icons.add),
              ),
              TextField(
                controller: controllers[0],
                decoration: const InputDecoration(hintText: 'Nom'),
                onChanged: (value) {},
              ),
              TextField(
                controller: controllers[1],
                decoration: const InputDecoration(hintText: 'Photo'),
                onChanged: (value) {},
              ),
              TextField(
                controller: controllers[2],
                decoration: const InputDecoration(hintText: 'Âge'),
                onChanged: (value) {},
              ),
              TextField(
                controller: controllers[3],
                decoration: const InputDecoration(hintText: 'Robe'),
                onChanged: (value) {},
              ),
              TextField(
                controller: controllers[4],
                decoration: const InputDecoration(hintText: 'Race'),
                onChanged: (value) {},
              ),
              TextField(
                controller: controllers[5],
                decoration: const InputDecoration(hintText: 'Genre'),
                onChanged: (value) {},
              ),
              TextField(
                controller: controllers[6],
                decoration: const InputDecoration(hintText: 'Spécialité'),
                onChanged: (value) {},
              ),
              TextButton(
                  onPressed: () {
                    updateHorse();
                  },
                  child: const Text('Mettre à jour le cheval')),
              TextButton(
                  onPressed: () {
                    deleteHorse();
                  },
                  child: const Text('Supprimer le cheval')),
            ],
          ),
        )),
        bottomNavigationBar: const NavBar());
  }

  getHorses() async {
    List horses = await MongoDatabase.getHorses();

    if (horses.isEmpty) {
      return;
    }

    for (int i = 0; i < horses.length; i++) {
      var currHorse = horses[i];
      var id = currHorse['_id'].$oid;
      var name = currHorse['name'];
      var photo = currHorse['photo'];
      var age = currHorse['age'];
      var dress = currHorse['dress'];
      var race = currHorse['race'];
      var gender = currHorse['gender'];
      var speciality = currHorse['speciality'];

      HorseModel horse =
          HorseModel(name, photo, age, dress, race, gender, speciality);

      horse.id = id;

      _horses.add(horse);
      _horsesNames.add(name);
    }

    setState(() {
      _horses = _horses;
      _horsesNames = _horsesNames;

      if (_horses.isNotEmpty) {
        horse = _horses.first;
      }
    });
  }

  addHorse() async {
    HorseModel horse =
        HorseModel('Horse${Random().nextInt(10000)}', '', '', '', '', '', '');

    horse.id = await MongoDatabase.addHorse(horse);
    _horses.add(horse);

    setState(() {
      _horses = _horses;
      _horsesNames.add(horse.name!);
    });
  }

  updateHorse() async {
    await MongoDatabase.updateHorse(
        horse.name,
        HorseModel(
            controllers[0].text,
            controllers[1].text,
            controllers[2].text,
            controllers[3].text,
            controllers[4].text,
            controllers[5].text,
            controllers[6].text));
  }

  deleteHorse() async {
    await MongoDatabase.deleteHorse(horse.name);
  }
}
