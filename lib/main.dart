import 'package:flutter/material.dart';
import 'package:horses_app/screens/Home.dart';
import 'package:horses_app/screens/Horse.dart';
import 'package:horses_app/screens/Profile.dart';

import 'config/mongodb.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      initialRoute: '/',
      routes: {
        '/home': (context) => const Home(),
        '/horse': (context) => const Horse(),
        '/login': (context) => const Profile(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home()
    );
  }
}