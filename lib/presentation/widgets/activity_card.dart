import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String date;
  final double price;


  const ActivityCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.date,
    required this.price,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      child :ListTile(
      leading: Image(
        width: 75,
        height: 100,
        fit: BoxFit.cover,
        image: AssetImage('assets/images/bgHoliday.jpg'),
      ),
      title:
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              color: Color(0xFF1E3A8A),
              fontWeight: FontWeight.bold,
            ),
          ),

      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
        Text(
        date,
        style: TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
      ),
          Text('${price} €'),
        ],
      ),
      trailing: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          shape: BoxShape.circle, // cerle en fond
          color: Color(0xFF1E3A8A),
        ),
        child: IconButton(
          onPressed: () {
            print('Add appuyé');
          },
          icon: Icon(
            Icons.remove_red_eye,
            size: 20,
            color: Colors.white,
          ),
        ),
      ),
    ),
    );
  }
}
