import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:holiday_mobile/presentation/widgets/holiday_tile.dart';
import 'package:auto_route/annotations.dart';
import 'package:holiday_mobile/routes/app_router.gr.dart';

@RoutePage()
class ListHolidaysChat extends StatefulWidget {
  const ListHolidaysChat({super.key});

  @override
  State<ListHolidaysChat> createState() => _ListHolidaysChatState();
}

class _ListHolidaysChatState extends State<ListHolidaysChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes groupes de vacances'),
      ),

      body: ListView(
        children: <Widget>[
          HolidayTile(
            onTap: () {
              context.router.push(const ChatRoute());
            },
          ),
        ],
      ),
    );
  }
}
