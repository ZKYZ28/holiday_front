import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:holiday_mobile/routes/app_router.gr.dart';

import '../../../routes/app_router.dart';

class BottomNavBar extends StatelessWidget {
  final AppRouter appRouter;

  const BottomNavBar({
    required this.appRouter,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black,
      backgroundColor: const Color(0xFF1E3A8A),
      iconSize: 22,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.holiday_village),
          label: 'Vacances',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined),
          label: 'Se déconnecter',
        ),
      ],
      onTap: (int index) {
        if (index == 0) {
          appRouter.push(const HolidaysRoute());
        } else if (index == 1) {
          appRouter.push(const ListHolidaysChat());
        } else if (index == 2) {
          // Gérer la déconnexion
          print("CLIQUE LOGOUT");
        }
      },
    );
  }
}