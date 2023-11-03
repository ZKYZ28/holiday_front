import 'package:flutter/material.dart';
import 'package:holiday_mobile/presentation/widgets/bottom_navbar.dart';
import 'package:holiday_mobile/routes/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    AppRouter appRouter = AppRouter();
    return MaterialApp(
      home: Scaffold(
        body: MaterialApp.router(
          routerConfig: appRouter.config(),
        ),
        bottomNavigationBar: BottomNavBar(appRouter: appRouter),
      ),
    );
  }
}

