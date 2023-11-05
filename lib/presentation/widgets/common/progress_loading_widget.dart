import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingProgressor extends StatelessWidget {
  const LoadingProgressor({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
