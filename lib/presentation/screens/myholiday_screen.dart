import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:holiday_mobile/presentation/screens/chat_page.dart';
import 'package:holiday_mobile/presentation/widgets/activity_card.dart';
import 'package:holiday_mobile/presentation/widgets/participant_card.dart';

import '../widgets/activity_container.dart';
import '../widgets/weather_card.dart';

class WeatherInfo {
  final String dayOfWeek;
  final int chanceOfRain;
  final String weatherIconPath;
  final double tempMin;
  final double tempMax;

  WeatherInfo({
    required this.dayOfWeek,
    required this.chanceOfRain,
    required this.weatherIconPath,
    required this.tempMin,
    required this.tempMax,
  });
}

class MyHolidayPage extends StatefulWidget {
  const MyHolidayPage({super.key});

  @override
  State<MyHolidayPage> createState() => _MyHolidayPageState();
}

class _MyHolidayPageState extends State<MyHolidayPage> {

  final List<WeatherInfo> weatherData = [
    WeatherInfo(
        dayOfWeek: 'Lundi',
        chanceOfRain: 30,
        weatherIconPath: 'assets/images/weather.png',
        tempMin: 15.0,
        tempMax: 15.0),
    WeatherInfo(
        dayOfWeek: 'Mardi',
        chanceOfRain: 30,
        weatherIconPath: 'assets/images/weather.png',
        tempMin: 16.0,
        tempMax: 15.0),
    WeatherInfo(
        dayOfWeek: 'Mercredi',
        chanceOfRain: 30,
        weatherIconPath: 'assets/images/weather.png',
        tempMin: 17.0,
        tempMax: 15.0),
  ];

  final List<ActivityData> activityData = [
    ActivityData(
        title: 'Drift',
        description: 'Lorepppppppppppppppppppppppppppppppppppppppppppppppppppppppp',
        date: '28-03-2022',
        price: 12.25,
        numberParticipants: 5),
    ActivityData(
        title: 'Mouloud',
        description: 'Lorepppppppppppppppppppppppppppppppppppppppppppppppppppppppp',
        date: '28-03-2022',
        price: 18.25,
        numberParticipants: 5),
    ActivityData(
        title: 'Camion',
        description: 'Lorepppppppppppppppppppppppppppppppppppppppppppppppppppppppp',
        date: '28-03-2022',
        price: 12.25,
        numberParticipants: 5),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculez les largeurs des colonnes en pourcentage
    final nameColumnWidth = screenWidth * 0.20;
    final emailColumnWidth = screenWidth * 0.45;
    final buttonColumnWidth = screenWidth * 0.20;
    final tableParticipantHeight = screenHeight * 0.30;
    final cardActivityHeight = screenHeight * 0.67;
    final cardActivityListView = screenHeight * 0.55;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mes vacances',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.visible,
                          color: Color(0xFF1E3A8A),
                        ),
                      ),
                      Text(
                        '28/03/2022',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E3A8A),
                        ),
                      )
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        EdgeInsets.only(left: 10, right: 10)),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Color(0xFF1E3A8A);
                        }
                        return Color(0xFF1E3A8A);
                      },
                    ),
                  ),
                  icon: const Icon(Icons.chat),
                  label: const Text('Chatter'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (_, __, ___) => ChatPage()));
                  },
                ),
              ],
            ),
            // Tableau des participants
            ParticipantCard(
              nameColumnWidth: nameColumnWidth,
              emailColumnWidth: emailColumnWidth,
              buttonColumnWidth: buttonColumnWidth,
              tableParticipantsHeight: tableParticipantHeight,
              title: 'Participant(s)',
              icon: Icons.add,
            ),
            // Météo
            // Card(
            //     elevation: 5,
            //     child: Column(
            //       children: [
            //         // Header
            //         Container(
            //           margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Text(
            //                 'Lieu : Monaco',
            //                 style: TextStyle(
            //                     fontWeight: FontWeight.bold,
            //                     fontSize: 20,
            //                     color: Color(0xFF1E3A8A)),
            //               ),
            //               ElevatedButton.icon(
            //                 style: ButtonStyle(
            //                   padding: MaterialStateProperty.all(
            //                       EdgeInsets.only(left: 10, right: 10)),
            //                   backgroundColor:
            //                       MaterialStateProperty.resolveWith<Color>(
            //                     (Set<MaterialState> states) {
            //                       if (states.contains(MaterialState.pressed)) {
            //                         return Color(0xFF1E3A8A);
            //                       }
            //                       return Color(0xFF1E3A8A);
            //                     },
            //                   ),
            //                 ),
            //                 icon: const Icon(Icons.cloud),
            //                 label: const Text('Visualiser'),
            //                 onPressed: () {
            //                   Navigator.push(
            //                       context,
            //                       PageRouteBuilder(
            //                           pageBuilder: (_, __, ___) => ChatPage()));
            //                 },
            //               )
            //             ],
            //           ),
            //         ),
            //         // Permet de faire une ligne séparatrice
            //         Divider(
            //           color: Colors.grey,
            //           thickness: 1, // Épaisseur de la ligne
            //         ),
            //
            //         // Toute la partie météo en -dessous du header
            //         WeatherCard(weatherData: weatherData),
            //       ],
            //     )),

            ActivityContainer(activities: activityData, activityHeight:cardActivityHeight, listViewHeight: cardActivityListView)
          ],
        ),
      ),
    );
  }
}
