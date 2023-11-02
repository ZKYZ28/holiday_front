import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:holiday_mobile/presentation/widgets/participant_card.dart';

class MyHolidayPage extends StatefulWidget {
  const MyHolidayPage({super.key});

  @override
  State<MyHolidayPage> createState() => _MyHolidayPageState();
}

class _MyHolidayPageState extends State<MyHolidayPage> {

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculez les largeurs des colonnes en pourcentage
    final nameColumnWidth = screenWidth * 0.20;
    final emailColumnWidth = screenWidth * 0.45;
    final buttonColumnWidth = screenWidth * 0.20;
    final tableParticipantsHeight = screenHeight * 0.23;

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          ParticipantCard(
              nameColumnWidth: nameColumnWidth,
              emailColumnWidth: emailColumnWidth,
              buttonColumnWidth: buttonColumnWidth,
              tableParticipantsHeight: tableParticipantsHeight,
              title: 'Participant(s)',
              icon: Icons.add,
          )
        ],
      ),
    );
  }
}
