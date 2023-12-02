import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holiday_mobile/configuration.dart';
import 'package:holiday_mobile/data/models/holiday/holiday.dart';
import 'package:holiday_mobile/logic/blocs/holiday_bloc/holiday_bloc.dart';
import 'package:holiday_mobile/main.dart';
import 'package:holiday_mobile/routes/app_router.gr.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart';

import '../common/icon_with_text.dart';

class HolidayCard extends StatelessWidget {
  final Holiday holiday;
  final VoidCallback onRemove;
  final Future<void> Function() afterNavigation;

  const HolidayCard({super.key, required this.holiday, required this.onRemove, required this.afterNavigation});

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormatDay = DateFormat('dd-MM-yyyy');

    return InkWell(
      onTap: () async {
        context.read<HolidayBloc>().add(ResetHolidayStatus());
        context.router.push(MyHolidayRoute(holidayId: holiday.id!)).then((value) async => await afterNavigation());
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(), // Pour mettre les éléments à droite

                  !holiday.isPublish
                      ?
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          // Action d'édition
                          context.router.push(EncodeHoliday(holiday: holiday)).then((value) async => await afterNavigation());
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          showDeleteConfirmationDialog(context, holiday);
                        },

                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ):  Container(),

                  holiday.isPublish
                      ? Container(
                      margin: const EdgeInsets.only(left: 8),
                        child: const Icon(
                          Icons.publish,
                          color: Colors.blue,
                  ),
                      ) : Container(),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    flex: 2, // La partie image occupe 2 parts sur 5 (40%)
                    child: Image.network(
                        '${Configuration().baseUrl}${holiday.holidayPath}'),
                  ),
                  Flexible(
                    flex: 3, // La colonne occupe 3 parts sur 5 (60%)
                    child: Container(
                      margin: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: Text(
                              holiday.name,
                              style: const TextStyle(
                                fontSize: 22,
                                color: Color(0xFF1E3A8A),
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          iconWithText(Icons.calendar_month, '${dateFormatDay.format(TZDateTime.parse(globalLocation!, holiday.startDate))}\n${dateFormatDay.format(TZDateTime.parse(globalLocation!, holiday.endDate))}'),
                          iconWithText(Icons.location_on, holiday.location.country),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                // Marge pour le Text
                child: Text(
                  holiday.description ?? '',
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showDeleteConfirmationDialog(BuildContext context, Holiday holiday) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmation"),
          content: Text("Etes-vous sûr de vouloir supprimer ${holiday.name}"),
          actions: [
            ButtonBar(
              alignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Fermer la popup
                  },
                  child: const Text("Annuler"),
                ),
                TextButton(
                  onPressed: () {
                    context.read<HolidayBloc>().add(DeleteHoliday(holidayId: holiday.id!));
                    onRemove();
                    Navigator.of(context).pop();
                  },
                  child: const Text("Supprimer"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
