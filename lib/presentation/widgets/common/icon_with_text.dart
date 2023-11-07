import 'package:flutter/material.dart';

Container iconWithText(IconData icon, String text) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8.0),
    child: Row(
      children: [
        Icon(icon),
        const SizedBox(width: 8.0),
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}