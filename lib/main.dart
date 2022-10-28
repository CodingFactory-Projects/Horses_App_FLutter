import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horses_app/Component/Form/FormContest.dart';
import 'package:horses_app/Component/Form/FormLogin.dart';
import 'package:horses_app/config/mongodb.dart';

import 'Component/Form/FormCursus.dart';
import 'Component/Form/PartyForm.dart';
import 'config/EventController.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'title'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
                                          print('object');
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
    return Card(
      shadowColor: Colors.black,
      child: SizedBox(
          width: 300,
          height: 100,
          child: DecoratedBox(
            decoration: const BoxDecoration(
                color: Colors.red
            ),
            child: Column(
              children: [
                AppBar(
                  actions: [
                    Text(this.title)
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
                    (person.level != null) ? Text(
                        person.level) : Text(''),
                    (person.name!= null) ? Text(
                        person.name) : Text(''),
                    (person.adress != null) ? Text(
                        person.adress) : Text(''),
                  ],
                 

                )
              ],
            ),
          )

      ),
    );
  }

}
