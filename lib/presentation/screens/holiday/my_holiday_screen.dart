import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holiday_mobile/data/models/holiday/holiday.dart';
import 'package:holiday_mobile/logic/blocs/holiday_bloc/holiday_bloc.dart';
import 'package:holiday_mobile/logic/blocs/participant_bloc/participant_bloc.dart';
import 'package:holiday_mobile/presentation/widgets/activity/activity_container.dart';
import 'package:holiday_mobile/presentation/widgets/common/custom_message.dart';
import 'package:holiday_mobile/presentation/widgets/common/progress_loading_widget.dart';
import 'package:holiday_mobile/presentation/widgets/holiday/holiday_published_button.dart';
import 'package:holiday_mobile/presentation/widgets/participant/participant_card.dart';
import 'package:holiday_mobile/routes/app_router.gr.dart';

import '../chat/chat_page.dart';

@RoutePage()
class MyHolidayPage extends StatefulWidget {
  final String holidayId;

  const MyHolidayPage({super.key, @PathParam() required this.holidayId});

  //Création de l'état
  @override
  _MyHolidayPageState createState() => _MyHolidayPageState();
}

class _MyHolidayPageState extends State<MyHolidayPage> {
  //Création du bloc
  late Holiday _holiday;

  //Création du bloc
  final ParticipantBloc _participantBloc = ParticipantBloc();

  @override
  void initState() {
    context.read<HolidayBloc>().add(GetHoliday(holidayId: widget.holidayId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TITRE VACANCES',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.visible,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'DATE DEBUT VACANCES',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton.icon(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    const EdgeInsets.only(left: 10, right: 10)),
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
                context.router.push(const ChatRoute());
              },
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1E3A8A),
      ),
      body: _buildMyHoliday(),
    );
  }

  Widget _buildMyHoliday() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<HolidayBloc>(create: (_) =>   context.read<HolidayBloc>()),
          BlocProvider<ParticipantBloc>(create: (_) => _participantBloc),
        ],
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
                        CustomMessage(message: state.errorMessage!)
                            .build(context));
                } else if (state.status == ParticipantStateStatus.left){
                  context.router.pop(context);
                }
              },
            ),
          ],
          child: BlocProvider(
            create: (_) =>   context.read<HolidayBloc>(),
            child: BlocBuilder<HolidayBloc, HolidayState>(
              builder: (context, state) {
                if (state.status == HolidayStateStatus.initial ||
                    state.status == HolidayStateStatus.loading) {
                  return const LoadingProgressor();
                } else if (state.status == HolidayStateStatus.loaded ||
                    state.status == HolidayStateStatus.published) {
                  if (state.status == HolidayStateStatus.loaded) {
                    _holiday = state.holidayItem!;
                  }
                  return _buildHoliday(context, _holiday!);
                } else {
                  return Container();
                }
              },
            ),
          ),
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
                Expanded(
                  child: Padding(
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
                        context.router
                            .push(WeatherRoute(holidayId: holiday.id!));
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),

                      //SI VACANCES PUBLIEE
                      child: holiday.isPublish
                          ? const PublishedButton()

                          //SI VACANCES NON PUBLIEE
                          : BlocBuilder<HolidayBloc, HolidayState>(
                              builder: (context, state) {
                                if (state.status ==
                                    HolidayStateStatus.published) {
                                  return const PublishedButton();
                                } else {
                                  return ElevatedButton.icon(
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.symmetric(
                                              horizontal: 10)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color(0xFF1E3A8A)),
                                    ),
                                    icon: const Icon(Icons.publish),
                                    label: const Text('Publier'),
                                    onPressed: () {
                                      context.read<HolidayBloc>().add(
                                          PublishHoliday(holiday: holiday));
                                    },
                                  );
                                }
                              },
                            )),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(horizontal: 10)),
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                      icon: const Icon(Icons.exit_to_app),
                      label: const Text('Quitter'),
                      onPressed: () {
                        //TODO CHANGE PARTICIPANT ID QUAND ON SERA CONNECTE
                        _participantBloc.add(LeaveHoliday(
                            participantId: "c01eb36d-d676-4878-bc3c-b9710e4a37ba",
                            holiday: holiday));
                      },
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
            ),

            ActivityContainer(
                activities: holiday.activities,
                activityHeight: cardActivityHeight,
                holidayId: widget.holidayId
            )],
        ),
      ),
    );
  }
}
