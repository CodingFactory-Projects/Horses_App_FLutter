import 'package:flutter/material.dart';
import 'package:horses_app/config/mongodb.dart';

import 'screens/Home.dart';
import 'screens/Login.dart';
import 'screens/Register.dart';

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
      initialRoute: '/',
      routes: {
        '/register': (context) => const Register(),
        '/login': (context) => const Login(),

      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}