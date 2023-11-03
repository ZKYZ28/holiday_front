import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/myholiday_screen.dart';

class WeatherCard extends StatefulWidget {
  const WeatherCard({
    super.key,
    required this.weatherData,
  });

  final List<WeatherInfo> weatherData;

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {

  String currentCondition = 'Sunny';
  String currentTemperature = '23 °C';
  String currentImage = 'assets/images/weather.png';
  String currentDate = 'Vendredi, 03-11-2023 | 14h30';


  void _updateWeatherInfo(WeatherInfo weatherInfo) {
    setState(() {
      currentTemperature = '${weatherInfo.tempMin} °C';
      currentDate = weatherInfo.dayOfWeek;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // Info météo maintenant
          Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: const Text(
                    'Sunny',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E3A8A)),
                  ),
                ),
                 Text(
                   currentTemperature,
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E3A8A)),
                ),
                const Image(
                    height: 60,
                    image: AssetImage(
                        'assets/images/weather.png')),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child:  Text(
                    //'Vendredi, 03-11-2023 | 14h30',
                    currentDate,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                )
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Aujourd'hui",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E3A8A)),
                ),

                // Slider horizontal
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100,
                        width: 70,
                        child: const Card(
                          color: Color(0xFFEFF6FF),
                          elevation: 5,
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Text(
                                '00:00',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  // color: Color(0xFF1E3A8A)
                                ),
                              ),
                              Image(
                                  height: 40,
                                  image: AssetImage(
                                      'assets/images/weather.png')),
                              Text(
                                '23.0 °C',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 70,
                        child: const Card(
                          color: Color(0xFFEFF6FF),
                          elevation: 5,
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Text(
                                '01:00',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  // color: Color(0xFF1E3A8A)
                                ),
                              ),
                              Image(
                                  height: 40,
                                  image: AssetImage(
                                      'assets/images/weather.png')),
                              Text(
                                '23.0 °C',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 70,
                        child: const Card(
                          color: Color(0xFFEFF6FF),
                          elevation: 5,
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Text(
                                '02:00',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  // color: Color(0xFF1E3A8A)
                                ),
                              ),
                              Image(
                                  height: 40,
                                  image: AssetImage(
                                      'assets/images/weather.png')),
                              Text(
                                '23.0 °C',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 70,
                        child: const Card(
                          color: Color(0xFFEFF6FF),
                          elevation: 5,
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Text(
                                '03:00',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  // color: Color(0xFF1E3A8A)
                                ),
                              ),
                              Image(
                                  height: 40,
                                  image: AssetImage(
                                      'assets/images/weather.png')),
                              Text(
                                '23.0 °C',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 70,
                        child: const Card(
                          color: Color(0xFFEFF6FF),
                          elevation: 5,
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Text(
                                '04:00',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  // color: Color(0xFF1E3A8A)
                                ),
                              ),
                              Image(
                                  height: 40,
                                  image: AssetImage(
                                      'assets/images/weather.png')),
                              Text(
                                '23.0 °C',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 70,
                        child: const Card(
                          color: Color(0xFFEFF6FF),
                          elevation: 5,
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Text(
                                '05:00',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  // color: Color(0xFF1E3A8A)
                                ),
                              ),
                              Image(
                                  height: 40,
                                  image: AssetImage(
                                      'assets/images/weather.png')),
                              Text(
                                '23.0 °C',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 70,
                        child: const Card(
                          color: Color(0xFFEFF6FF),
                          elevation: 5,
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Text(
                                '10:00',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  // color: Color(0xFF1E3A8A)
                                ),
                              ),
                              Image(
                                  height: 40,
                                  image: AssetImage(
                                      'assets/images/weather.png')),
                              Text(
                                '23.0 °C',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 70,
                        child: const Card(
                          color: Color(0xFFEFF6FF),
                          elevation: 5,
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Text(
                                '10:00',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  // color: Color(0xFF1E3A8A)
                                ),
                              ),
                              Image(
                                  height: 40,
                                  image: AssetImage(
                                      'assets/images/weather.png')),
                              Text(
                                '23.0 °C',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 70,
                        child: const Card(
                          color: Color(0xFFEFF6FF),
                          elevation: 5,
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Text(
                                '10:00',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  // color: Color(0xFF1E3A8A)
                                ),
                              ),
                              Image(
                                  height: 40,
                                  image: AssetImage(
                                      'assets/images/weather.png')),
                              Text(
                                '23.0 °C',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 70,
                        child: const Card(
                          color: Color(0xFFEFF6FF),
                          elevation: 5,
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Text(
                                '10:00',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  // color: Color(0xFF1E3A8A)
                                ),
                              ),
                              Image(
                                  height: 40,
                                  image: AssetImage(
                                      'assets/images/weather.png')),
                              Text(
                                '23.0 °C',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 70,
                        child: const Card(
                          color: Color(0xFFEFF6FF),
                          elevation: 5,
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Text(
                                '10:00',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  // color: Color(0xFF1E3A8A)
                                ),
                              ),
                              Image(
                                  height: 40,
                                  image: AssetImage(
                                      'assets/images/weather.png')),
                              Text(
                                '23.0 °C',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: const Text(
                    "Prochains jours",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E3A8A)),
                  ),
                ),

                // Prochains jour

                DataTable(
                  showCheckboxColumn: false,
                  columnSpacing: 20,
                  headingRowHeight: 0,
                  // de cette manière, on cache le heaedr
                  columns: [
                    const DataColumn(label: Text('')),
                    const DataColumn(label: Text('')),
                    const DataColumn(label: Text('')),
                    const DataColumn(label: Text('')),
                    const DataColumn(label: Text('')),
                  ],
                  rows: widget.weatherData.asMap().map((index, weatherInfo) {
                    return MapEntry(index, DataRow(
                        cells: [
                          DataCell(Text('${weatherInfo.dayOfWeek}')),
                          DataCell(Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.water_drop,
                                color: Color(0xFF1E3A8A),
                              ),
                              Text('${weatherInfo.chanceOfRain}%')
                            ],
                          )),
                          DataCell(Image(
                              height: 40,
                              image: AssetImage(
                                  weatherInfo.weatherIconPath))),
                          DataCell(
                              Text('${weatherInfo.tempMin} °C')),
                          DataCell(
                              Text('${weatherInfo.tempMax} °C'))
                        ],
                        onSelectChanged: (_) {
                          print(index);
                          _updateWeatherInfo(widget.weatherData[index]);
                        }
                    ));
                  }).values.toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}