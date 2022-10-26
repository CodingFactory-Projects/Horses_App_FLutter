import 'package:flutter/material.dart';
import 'package:horses_app/config/mongodb.dart';

import 'screens/Home.dart';
import 'screens/Login.dart';
import 'screens/Register.dart';

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
      initialRoute: "/",
      routes: {
        '/home': (context) => const Home(),
        '/login': (context) => const Login(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home()
    );
  }
}