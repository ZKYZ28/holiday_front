import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: const <TextSpan>[
                  TextSpan(text: "Holiday", style: TextStyle(color: Colors.black)),
                  TextSpan(text: ".", style: TextStyle(color: Colors.lightBlueAccent)),
                ],
              ),
            ),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
