import 'package:flutter/material.dart';

class PublishedButton extends StatelessWidget {

  const PublishedButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.0,
      decoration: BoxDecoration(
        color: const Color(0xFF6c757d),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: const Center(
        child: Text(
          "Publiée",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}