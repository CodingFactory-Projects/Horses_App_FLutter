import 'package:flutter/material.dart';
import 'package:horses_app/config/mongodb.dart';

import 'screens/Home.dart';
import 'screens/Login.dart';
import 'screens/Register.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  Map<int, Color> colorCodes = {
    50: const Color.fromRGBO(147, 205, 72, .1),
    100: const Color.fromRGBO(147, 205, 72, .2),
    200: const Color.fromRGBO(147, 205, 72, .3),
    300: const Color.fromRGBO(147, 205, 72, .4),
    400: const Color.fromRGBO(147, 205, 72, .5),
    500: const Color.fromRGBO(147, 205, 72, .6),
    600: const Color.fromRGBO(147, 205, 72, .7),
    700: const Color.fromRGBO(147, 205, 72, .8),
    800: const Color.fromRGBO(147, 205, 72, .9),
    900: const Color.fromRGBO(147, 205, 72, 1),
  };

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
          primarySwatch: MaterialColor(0xFF2596be, colorCodes),
          scaffoldBackgroundColor: const Color(0xFFeeeee4)),
      home: const Home(),
    );
  }
}
