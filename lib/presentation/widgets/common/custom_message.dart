import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class CustomMessage extends StatelessWidget {
  final String message;

  CustomMessage({required this.message});


  @override
  MaterialBanner build(BuildContext context) {
     return MaterialBanner(
      elevation: 0,
      backgroundColor: Colors.transparent,
      forceActionsBelow: true,
      content: AwesomeSnackbarContent(
        title: 'ERREUR',
        message: message,
        contentType: ContentType.failure,
        inMaterialBanner: true,
      ),
      actions: const [SizedBox.shrink()],
    );
  }
}