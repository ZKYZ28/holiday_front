import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holiday_mobile/data/providers/authentification_api_provider.dart';
import 'package:holiday_mobile/data/providers/dio_instance.dart';
import 'package:holiday_mobile/data/repositories/authentification_api_repository.dart';
import 'package:holiday_mobile/logic/blocs/auth_bloc/auth_bloc.dart';
import 'package:holiday_mobile/presentation/widgets/common/bottom_navbar.dart';
import 'package:holiday_mobile/routes/app_router.dart';


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host,
          int port) => true;
  }
}


void main() {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
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
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthAPiProvider>(
              create: (context) => AuthAPiProvider())
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
                create: (context) => AuthBloc(repository: AuthRepository()))
          ],
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              // TODO: implement listener
              // TODO ECOUTER LES CHANGEMENTS D'ETAT TOUT AU DESSUS DE L'APPLICATION PUIS QUAND AUTHENTIFICATIOn.disconnected survient -->
              //  pouf fortnite top 1 login
            },
            child: MaterialApp(
              home: Scaffold(
                body: MaterialApp.router(
                  routerConfig: appRouter.config(),
                ),
                bottomNavigationBar: BottomNavBar(appRouter: appRouter),
              ),
            ),
          ),
        )
    );
  }
}

