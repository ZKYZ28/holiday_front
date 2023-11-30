import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holiday_mobile/data/models/holiday/holiday.dart';
import 'package:holiday_mobile/logic/blocs/chat_bloc/chat_bloc.dart';
import 'package:holiday_mobile/logic/blocs/holiday_bloc/holiday_bloc.dart';
import 'package:holiday_mobile/logic/blocs/participant_bloc/participant_bloc.dart';
import 'package:holiday_mobile/main.dart';
import 'package:holiday_mobile/presentation/widgets/activity/activity_container.dart';
import 'package:holiday_mobile/presentation/widgets/common/custom_message.dart';
import 'package:holiday_mobile/presentation/widgets/common/progress_loading_widget.dart';
import 'package:holiday_mobile/presentation/widgets/holiday/holiday_published_button.dart';
import 'package:holiday_mobile/presentation/widgets/participant/participant_card.dart';
import 'package:holiday_mobile/routes/app_router.gr.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart';

@RoutePage()
class MyHolidayPage extends StatefulWidget {
  final String holidayId;

  const MyHolidayPage({super.key, @PathParam() required this.holidayId});

  //Création de l'état
  @override
  _MyHolidayPageState createState() => _MyHolidayPageState();
}

class _MyHolidayPageState extends State<MyHolidayPage> {
  late Holiday _holiday;
  @override
  void initState() {
    context.read<HolidayBloc>().add(GetHoliday(holidayId: widget.holidayId));
    super.initState();
  }

  Future<void> _afterEncodeOrEdit() async {
    context.read<HolidayBloc>().add(GetHoliday(holidayId: widget.holidayId));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<HolidayBloc, HolidayState>(
                    buildWhen: (previousState, currentState) {
                      return currentState.status == HolidayStateStatus.loaded;
                    },
                    builder: (context, state) {
                      if (state.status == HolidayStateStatus.loaded ||
                          state.status ==
                              HolidayStateStatus.waitingActivityAction) {
                        _holiday = state.holidayItem!;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _holiday != null ? _holiday.name : "",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              _holiday != null
                                  ? DateFormat('dd/MM/yyyy').format(TZDateTime.parse(globalLocation!, _holiday.startDate))
                                  : "",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton.icon(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  const EdgeInsets.only(left: 5, right: 5)),
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return const Color(0xFF1E3A8A);
                  }
                  return const Color(0xFF1E3A8A);
                },
              ),
            ),
            icon: const Icon(Icons.calendar_month),
            label: const Text('Exporter'),
            onPressed: () {
              context
                  .read<HolidayBloc>()
                  .add(ExportHolidayToIcs(holidayId: widget.holidayId));
            },
          ),
          ElevatedButton.icon(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  const EdgeInsets.only(left: 5, right: 5)),
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return const Color(0xFF1E3A8A);
                  }
                  return const Color(0xFF1E3A8A);
                },
              ),
            ),
            icon: const Icon(Icons.chat),
            label: const Text('Chatter'),
            onPressed: () {
              context.router
                  .push(ChatRoute(
                      holidayId: widget.holidayId, holidayName: _holiday.name))
                  .then((value) => context
                      .read<ChatBloc>()
                      .add(LeaveRoom(holidayId: widget.holidayId)));
              context
                  .read<ChatBloc>()
                  .add(JoinRoom(holidayId: widget.holidayId));
            },
          ),
        ],
        backgroundColor: const Color(0xFF1E3A8A),
      ),
      body: _buildMyHoliday(),
    );
  }

  Widget _buildMyHoliday() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: MultiBlocListener(
        listeners: [
          BlocListener<HolidayBloc, HolidayState>(
            listener: (context, state) {
              if (state.status == HolidayStateStatus.error) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentMaterialBanner()
                  ..showMaterialBanner(
                      CustomMessage(message: state.errorMessage!)
                          .build(context));
              }
            },
          ),
          BlocListener<ParticipantBloc, ParticipantState>(
            listener: (context, state) {
              if (state.status == ParticipantStateStatus.error) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentMaterialBanner()
                  ..showMaterialBanner(
                      CustomMessage(message: state.errorMessage)
                          .build(context));
              } else if (state.status == ParticipantStateStatus.left) {
                context.router.pop(context);
              }
            },
          ),
        ],
        child: BlocBuilder<HolidayBloc, HolidayState>(
          builder: (context, state) {
            if (state.status == HolidayStateStatus.initial ||
                state.status == HolidayStateStatus.loading) {
              return const LoadingProgressor();
            } else if (state.status == HolidayStateStatus.loaded ||
                state.status == HolidayStateStatus.published ||
                state.status == HolidayStateStatus.waitingActivityAction) {
              if (state.status == HolidayStateStatus.loaded || state.status == HolidayStateStatus.published) {
                if (state.holidayItem != null) {
                  _holiday = state.holidayItem!;
                }
              }
              return _buildHoliday(context, _holiday);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildHoliday(BuildContext context, Holiday holiday) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculez les largeurs des colonnes en pourcentage
    final nameColumnWidth = screenWidth * 0.20;
    final emailColumnWidth = screenWidth * 0.45;
    final buttonColumnWidth = screenWidth * 0.20;
    final tableParticipantHeight = screenHeight * 0.30;
    final cardActivityHeight = screenHeight * 0.45;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(horizontal: 10)),
                      backgroundColor:
                      MaterialStateProperty.all(const Color(0xFF1E3A8A)),
                    ),
                    icon: const Icon(Icons.cloud),
                    label: const Text('Météo'),
                    onPressed: () {
                      context.router.push(WeatherRoute(
                          holidayId: holiday.id!, holidayName: holiday.name));
                    },
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: holiday.isPublish
                        ? const PublishedButton()
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(horizontal: 10)),
                              backgroundColor:
                              MaterialStateProperty.all(const Color(0xFF1E3A8A)),
                            ),
                            icon: const Icon(Icons.publish),
                            label: const Text('Publier'),
                            onPressed: () {
                              context
                                  .read<HolidayBloc>()
                                  .add(PublishHoliday(holiday: holiday));
                            },
                          ),
                        ),

                        const SizedBox(width: 4.0),

                        Expanded(
                          child: ElevatedButton.icon(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(horizontal: 10)),
                              backgroundColor: MaterialStateProperty.all(Colors.red),
                            ),
                            icon: const Icon(Icons.exit_to_app),
                            label: const Text('Quitter'),
                            onPressed: () {
                              context
                                  .read<ParticipantBloc>()
                                  .add(LeaveHoliday(holiday: holiday));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
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
              participants: holiday.participants,
              elementId: widget.holidayId,
              isPublish: _holiday.isPublish
            ),

            ActivityContainer(
                activities: holiday.activities,
                activityHeight: cardActivityHeight,
                holidayId: widget.holidayId,
                afterEncodeOrEdit : _afterEncodeOrEdit,
                isPublish: _holiday.isPublish
            )],
        ),
      ),
    );
  }
}
