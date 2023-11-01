import 'package:flutter/material.dart';
import 'package:holiday_mobile/presentation/screens/activity_page.dart';


void main() {
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
          title: const Text("Holiday"),
          backgroundColor: Color(0xFF1E3A8A),
        ),
        body: [
          Activity(),
        ][_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setCurrentIndex(index),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          backgroundColor: Color(0xFF1E3A8A),
          iconSize: 22,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.holiday_village),
                label: 'Vacances'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.message),
                label: 'Chat'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.logout),
                label: 'Se déconnecter'
            ),
          ],
        ),
      ),
    );
  }
}





