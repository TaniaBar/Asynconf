import 'package:cours_electron_midali/pages/add_event_page.dart';
import 'package:cours_electron_midali/pages/event_page.dart';
import 'package:cours_electron_midali/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {

  //pour etre sur que les dependences son ok sur l'appli au lancement de l'appli
  WidgetsFlutterBinding.ensureInitialized();

  //il va reconnaitre le dispositif du client(android, ios)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  int _currentIndex = 0;

  setCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const [
            Text("Accueil"),
            Text("Liste de conférences"),
            Text("Formulaire"),
          ][_currentIndex],
        ),
        body: const [
          HomePage(),
          EventPage(),
          AddEventPage()
        ][_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setCurrentIndex(index),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          iconSize: 32,
          elevation: 10,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Accueil'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month),
                label: 'Planning'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Ajout'
            )
          ],
        ),
      ),
    );
  }
}




  




