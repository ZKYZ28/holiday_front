import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String date;
  final String price;
  final String description;


  const ActivityCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.date,
    required this.price,
    required this.description,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image(
        width: 75,
        height: 100,
        fit: BoxFit.cover,
        image: AssetImage('assets/images/bgHoliday.jpg'),
      ),
      title: Text(title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(date),
          Text(price),
          SizedBox(
            width: 250,
            child: Text(description),
          )
        ],
      ),
      trailing: Wrap(
        direction: Axis.vertical,
        spacing: 12, // espace entre chaque bouton/icon
        children: <Widget>[
          TextButton(
            child: Text('Participant(s)'),
            onPressed: () {

            },
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {

            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {

            },
          ),
        ],
      ),
    );
  }
}
