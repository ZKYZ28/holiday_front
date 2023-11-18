import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holiday_mobile/data/models/invitation/invitation.dart';
import 'package:holiday_mobile/logic/blocs/holiday_bloc/holiday_bloc.dart';
import 'package:holiday_mobile/logic/blocs/invitation_bloc/invitation_bloc.dart';
import 'package:holiday_mobile/presentation/widgets/common/custom_message.dart';

import '../../../data/models/holiday/holiday.dart';
import '../../../routes/app_router.gr.dart';
import '../../widgets/common/progress_loading_widget.dart';
import '../../widgets/holiday/holiday_card.dart';

@RoutePage()
class HolidaysPage extends StatefulWidget {
  const HolidaysPage({super.key});

  //Création de l'état
  @override
  _HolidaysPageState createState() => _HolidaysPageState();
}

class _HolidaysPageState extends State<HolidaysPage> {
  //Création du bloc
  final HolidayBloc _holidayBloc = HolidayBloc();
  final InvitationBloc _invitationBloc = InvitationBloc();

  @override
  void initState() {
    //TODO CHANGER UNE FOIS QU'ON SERA CONNECTE
    _holidayBloc.add(const GetHolidayByParticipant(
      //TODO CHANGER UNE FOIS QU'ON SERA CONNECTE
        participantId: 'c01eb36d-d676-4878-bc3c-b9710e4a37ba'));
    _invitationBloc.add(const GetAllInvitationsByParticipant(
      //TODO CHANGER UNE FOIS QU'ON SERA CONNECTE
        participantId: 'c01eb36d-d676-4878-bc3c-b9710e4a37ba'));
    super.initState();
  }

  bool isToggled = false;
  List<Invitation> inivtationsList = [];
  List<Holiday> _holidays = [];

  void toggleSwitch(bool value) {
    setState(() {
      isToggled = value;

      // Appeler la méthode du bloc en fonction de la valeur de isToggled
      if (isToggled) {
        _holidayBloc.add(GetHolidayPublished());
      } else {
        //TODO CHANGER UNE FOIS QU'ON SERA CONNECTE
        _holidayBloc.add(const GetHolidayByParticipant(
            participantId: 'c01eb36d-d676-4878-bc3c-b9710e4a37ba'));
      }
    });
  }

  Future<void> _afterNavigation() async {
    //TODO CHANGER ICI
    _invitationBloc.add(const GetAllInvitationsByParticipant(participantId: "d48956dd-5a64-47c1-b0ee-1edd55650155"));
    _holidayBloc.add(const GetHolidayByParticipant(participantId: "c01eb36d-d676-4878-bc3c-b9710e4a37ba"));

    _buildListHoliday();
  }


  void _removeHoliday(Holiday holiday) {
    setState(() {
      _holidays.remove(holiday);
    });
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E3A8A),
        title: Text(isToggled
            ? 'Vacances publiées par les utilisateurs'
            : 'Mes vacances'),
        actions: [
          // INVITATIONS
          ElevatedButton(
            onPressed: () async {
              //TODO CHANGER UNE FOIS QU'ON SERA CONNECTE
              context.router.push(InvitationsRoute(participantId: "d48956dd-5a64-47c1-b0ee-1edd55650155")).then((value) async => await _afterNavigation());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E3A8A),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocProvider<InvitationBloc>.value(
                  value: _invitationBloc,
                  child: BlocBuilder<InvitationBloc, InvitationState>(
                    builder: (context, state) {
                      if (state.status == InvitationStateStatus.initial || state.status == InvitationStateStatus.loading) {
                        return const CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 15.0,
                          child: Text(
                            "0",
                            style: TextStyle(color: Colors.white),
                          ),
                        );

                      } else if (state.status == InvitationStateStatus.loaded || state.status == InvitationStateStatus.accepted) {
                        inivtationsList = state.invitationsList ?? [];
                        return CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 15.0,
                          child: Text(
                            inivtationsList.length.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8.0),
                const Text('Invitations'),
              ],
            ),
          ),

          //ENCODER UNE VACANCES
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Encoder'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E3A8A),
            ),
            onPressed: () {
              context.router.push(const EncodeHoliday());
            },
          ),
        ],
      ),
      body: _buildListHoliday(),
    );
  }

  Widget _buildListHoliday() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<HolidayBloc>(create: (_) => _holidayBloc),
          BlocProvider<InvitationBloc>(create: (_) => _invitationBloc),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<HolidayBloc, HolidayState>(
              listener: (context, state) {
                if (state.status == HolidayStateStatus.error) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentMaterialBanner()
                    ..showMaterialBanner(
                        CustomMessage(message: state.errorMessage!).build(context));
                }
              },
            ),
            BlocListener<InvitationBloc, InvitationState>(
              listener: (context, state) {
                if (state.status == InvitationStateStatus.error) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentMaterialBanner()
                    ..showMaterialBanner(
                        CustomMessage(message: state.errorMessage!).build(context));
                }
              },
            ),
          ],
          child: BlocBuilder<HolidayBloc, HolidayState>(
            builder: (context, state) {
              if (state.status == HolidayStateStatus.initial || state.status == HolidayStateStatus.loading) {
                return const LoadingProgressor();
              } else if (state.status == HolidayStateStatus.loaded) {
                _holidays = state.holidaysList ?? [];
                return _buildHolidayCard(context, _holidays);
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHolidayCard(BuildContext context, List<Holiday> holidays) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Switch(
              value: isToggled,
              onChanged: toggleSwitch,
              activeColor: const Color(0xFF1E3A8A),
            ),
            const Text('Vacances publiées/personnels'),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: holidays.length,
            itemBuilder: (context, index) {
              final holiday = holidays[index];
              return HolidayCard(
                  holiday: holiday,
                  holidayBloc: _holidayBloc,
                  onRemove: () => _removeHoliday(holiday),
                  afterNavigation: _afterNavigation,
              );
            },
          ),
        ),
      ],
    );
  }
}