import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horses_app/Component/Form/FormContest.dart';
import 'package:horses_app/Component/Form/FormLogin.dart';
import 'package:horses_app/config/mongodb.dart';

import '../config/EventController.dart';
import 'Form/FormCursus.dart';
import 'Form/PartyForm.dart';





class ActuPage extends StatefulWidget {
  const ActuPage({super.key, required this.title});

  final String title;

  @override
  State<ActuPage> createState() => _ActuPageState();
}

class _ActuPageState extends State<ActuPage> {
  var futureList = [];
  var showform = '';
  var eventController = EventController();
  addCart() async {
    var contest = await eventController.getConstestEvents();
    print(contest.typeEvent);
    futureList.add(_MyCard(person: contest, title: contest.typeEvent));
    setState(() {

    });


  }

  @override
  initState()  {
    super.initState();
    addCart();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child:
          ListView.builder(
              itemCount: futureList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    subtitle: futureList[index]
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              showDialog(
                context: context,
                builder: (context) {
                  String contentText = "Content of Dialog";
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return AlertDialog(
                          content: Container(
                            child: Column(
                              children: [
                                Row(
                                    children: [
                                      ElevatedButton(
                                        child: Text('Contest'),
                                        onPressed: (){
                                          print('object');
                                          showform = 'contest';
                                          setState(() {

                                          });
                                        },
                                      ),
                                      ElevatedButton(
                                        child: Text('Party'),
                                        onPressed: (){
                                          print('object');
                                          showform = 'party';
                                          setState(() {

                                          });
                                        },
                                      ),
                                      ElevatedButton(
                                        child: Text('Cursus'),
                                        onPressed: (){
                                          showform = 'cursus';
                                          setState(() {

                                          });
                                        },
                                      )
                                    ]
                                ),
                                (showform == 'contest')? ContestForm(title: 'Add Contest')
                                    :(showform == 'cursus') ? CursusForm(title: 'Add Cursus')
                                    :(showform == 'party') ? PartyForm(title: 'Add Party')
                                    : Text('select a event')
                              ],
                            ),

                          )

                      );
                    },
                  );
                },
              ),
          backgroundColor: Colors.green,
          child: const Icon(Icons.navigation),
        )
    );
  }
}





class _MyCard extends StatelessWidget {
  const _MyCard({required this.person , required this.title});
  final  person;
  final title;
  //final String adress;

  @override
  Widget build(BuildContext ctx) {

    var bytes = base64Decode(person.image);
    return Card(

      shadowColor: Colors.black,
      child: SizedBox(
          width: 300,
          height: 200,
          child: DecoratedBox(
            decoration: const BoxDecoration(
                color: Colors.red
            ),
            child: Column(
              children: [
                AppBar(
                  actions: [
                    Center(
                        child: Text(this.title,
                        )
                    )

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:  [
                    Text(person.date, style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:  [
                    (person.level != null) ? Text( 'level :' +
                        person.level) : const Text(''),
                    (person.name!= null) ? Text(
                        person.name) : const Text(''),
                    (person.adress != null) ? Text(
                        person.adress) : const Text(''),
                  ],




                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Color(0xff476cfb),
                      child: ClipOval(
                        child: SizedBox(
                            width: 90.0,
                            height: 90.0,
                            child: (person.image != null) ? Image.memory(bytes) : Text('')
                        ),
                      ),
                    ),
                  ],

                )
              ],
            ),
          )

      ),
    );
  }

}
