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
  List<TextEditingController> controllers = List<TextEditingController>.generate(
      8, (i) => TextEditingController()
  );

  String horseName = '';
  late HorseModel currHorse;

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
                value: horseName,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: _horsesNames.map((String horse) {
                  return DropdownMenuItem(
                    value: horse,
                    child: Text(horse),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  for (HorseModel horse in _horses) {
                    if (horse.name == horseName) {
                      currHorse = horse;
                    }
                  }

                  horseName = newValue!;

                  controllers[0].text = currHorse.name!;
                  controllers[1].text = currHorse.photo!;
                  controllers[2].text = currHorse.age!;
                  controllers[3].text = currHorse.dress!;
                  controllers[4].text = currHorse.race!;
                  controllers[5].text = currHorse.gender!;
                  controllers[6].text = currHorse.speciality!;

                  setState(() {
                    currHorse = currHorse;
                    horseName = horseName;
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
                onChanged: (value) {

                },
              ),
              TextField(
                controller: controllers[1],
                decoration: const InputDecoration(hintText: 'Photo'),
                onChanged: (value) {

                },
              ),
              TextField(
                controller: controllers[2],
                decoration: const InputDecoration(hintText: 'Âge'),
                onChanged: (value) {

                },
              ),
              TextField(
                controller: controllers[3],
                decoration: const InputDecoration(hintText: 'Robe'),
                onChanged: (value) {

                },
              ),
              TextField(
                controller: controllers[4],
                decoration: const InputDecoration(hintText: 'Race'),
                onChanged: (value) {

                },
              ),
              TextField(
                controller: controllers[5],
                decoration: const InputDecoration(hintText: 'Genre'),
                onChanged: (value) {

                },
              ),
              TextField(
                controller: controllers[7],
                decoration: const InputDecoration(hintText: 'Spécialité'),
                onChanged: (value) {

                },
              ),
            ],
          ),
        )),
        bottomNavigationBar: const NavBar());
  }

  getHorses() async {
    List horses = await MongoDatabase.select('horses');

    for (int i = 0; i < horses.length; i++) {
      var currHorse = horses[i];
      var id = currHorse['_id'].$oid;
      var name = currHorse['name'];

      HorseModel horse = HorseModel(
          name: name,
          photo: currHorse['photo'],
          age: currHorse['age'],
          dress: currHorse['dress'],
          race: currHorse['race'],
          gender: currHorse['gender'],
          speciality: currHorse['speciality']);

      horse.id = id;

      _horses.add(horse);
      _horsesNames.add(name);
    }

    setState(() {
      _horses = _horses;
      _horsesNames = _horsesNames;
      horseName = _horsesNames.first;
    });
  }

  addHorse() async {
    HorseModel horse = HorseModel(
        name: 'Horse${Random().nextInt(10000)}',
        photo: '',
        age: '',
        dress: '',
        race: '',
        gender: '',
        speciality: ''
    );

    horse.id = await MongoDatabase.addHorse(horse);
    _horses.add(horse);
  }
}
