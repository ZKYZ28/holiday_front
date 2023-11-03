import 'package:flutter/material.dart';
import 'package:holiday_mobile/presentation/router/app_router.dart';
import 'package:holiday_mobile/presentation/screens/activity_page.dart';
import 'package:holiday_mobile/presentation/screens/holidays_page.dart';
import 'package:holiday_mobile/presentation/screens/list_holidays_chat.dart';
import 'package:holiday_mobile/presentation/screens/myholiday_screen.dart';
import 'package:holiday_mobile/presentation/widgets/bottom_navbar.dart';


void main() {
  runApp(MyApp());
}
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


class MyApp extends StatefulWidget {
  final AppRouteur appRouter = AppRouteur();

   MyApp({
    Key? key,
  }) : super(key: key);


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
          centerTitle: true,
          title: const Text("Holiday"),
          backgroundColor: const Color(0xFF1E3A8A),
        ),

        body: [
          // Navigator(
          //   key : navigatorKey,
          //   onGenerateRoute: widget.appRouter.onGenerateRoute,
          //   initialRoute: '/',
          // )
          MyHolidayPage()
        ][_currentIndex],

        bottomNavigationBar: BottomNavBar(
          currentIndex: _currentIndex,
          onTap: setCurrentIndex,
        )
      ),
      // onGenerateRoute: widget.appRouter.onGenerateRoute,
    );
  }
}





