import 'package:flutter/material.dart';
import 'package:horses_app/config/mongodb.dart';
import 'package:horses_app/screens/Account.dart';
import 'package:horses_app/screens/Hall.dart';
import 'package:horses_app/screens/Home.dart';
import 'package:horses_app/screens/Horse.dart';
import 'package:horses_app/screens/Login.dart';
import 'package:horses_app/screens/Register.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(MyApp());
}

// ignore: must_be_immutable
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

  @override
  Widget build(BuildContext context) {
    // ScaffoldMessenger.of(context).hideCurrentSnackBar();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/register': (context) => Register(),
        '/login': (context) => Login(),
        '/hall': (context) => Hall(),
        '/horse': (context) => Horse(),
        '/account': (context) => Account(),
      },
      theme: ThemeData(
          primarySwatch: MaterialColor(0xFF2596be, colorCodes),
          scaffoldBackgroundColor: const Color(0xFFeeeee4)),
      home: Home(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final screens = [
    Hall(),
    Account(),
    Horse(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Compte',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Chevaux',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF2596be),
        onTap: _onItemTapped,
      ),
    );
  }
}
