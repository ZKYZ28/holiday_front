import 'package:flutter/material.dart';

class HolidayTile extends StatelessWidget {
  final void Function()? onTap;

  HolidayTile({this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: const Card(
        child: ListTile(
          leading: FlutterLogo(size: 56.0),
          title:  Text('Two-line ListTile'),
          subtitle:  Text('Here is a second line'),
        ),
      ),
    );
  }
}