import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String? message;

  ErrorMessage({this.message});

  @override
  Widget build(BuildContext context) {
    return Text(
      message!,
      style: const TextStyle(
        color: Colors.red, // Vous pouvez personnaliser la couleur
        fontSize: 16, // Vous pouvez personnaliser la taille de police
      ),
    );
  }
}