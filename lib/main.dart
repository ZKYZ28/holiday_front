import 'package:flutter/material.dart';
import 'package:holiday_mobile/presentation/screens/list_holidays_chat.dart';
import 'package:holiday_mobile/presentation/widgets/bottom_navbar.dart';


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
          backgroundColor: const Color(0xFF1E3A8A),
        ),

        body: [
          ListHolidaysChat(),
        ][_currentIndex],

        bottomNavigationBar: BottomNavBar(
          currentIndex: _currentIndex,
          onTap: setCurrentIndex,
        )
      ),
    );
  }
}





