import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:holiday_mobile/presentation/screens/chat/chat_page.dart';
import 'package:holiday_mobile/presentation/screens/holiday/holidays_page.dart';
import 'package:holiday_mobile/presentation/screens/chat/list_holidays_chat.dart';
import 'package:holiday_mobile/presentation/screens/holiday/myholiday_screen.dart';
import 'package:holiday_mobile/presentation/screens/authentification/register_page.dart';

class AppRouteur {

  // Cette méthode permet de naviguer vers un écran donné en paramètre.
  Route<dynamic> onGenerateRoute(RouteSettings routeToNavigate) {
    switch (routeToNavigate.name) {
      case '/':
      // renvoie une page MaterialApp
        return MaterialPageRoute(
            builder: (context) => ListHolidaysChat());
      case '/chat':
        return MaterialPageRoute(
            builder: (context) => ChatPage());
      case '/register':
        return MaterialPageRoute(
            builder: (context) => RegisterPage());
      case '/myholidaypage':
        return MaterialPageRoute(
            builder: (context) => MyHolidayPage());
      default:
      // S'il se perd, on le renvoie sur la page d'accueil
        return MaterialPageRoute(
            builder: (_) => ListHolidaysChat());
    }
  }


}