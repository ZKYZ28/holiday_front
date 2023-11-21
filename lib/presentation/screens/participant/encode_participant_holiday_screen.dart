import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holiday_mobile/data/models/participant/participant.dart';
import 'package:holiday_mobile/logic/blocs/invitation_bloc/invitation_bloc.dart';
import 'package:holiday_mobile/logic/blocs/participant_bloc/participant_bloc.dart';
import 'package:holiday_mobile/presentation/widgets/participant/addable_participant.dart';
import 'package:holiday_mobile/presentation/widgets/participant/my_search.dart';
import 'package:holiday_mobile/presentation/widgets/common/custom_message.dart';
import 'package:holiday_mobile/presentation/widgets/common/progress_loading_widget.dart';
import 'package:holiday_mobile/presentation/widgets/participant/participant_being_added.dart';


@RoutePage()
class EncodeParticipantHolidayScreen extends StatefulWidget {
  final String holidayId;

  const EncodeParticipantHolidayScreen({super.key, @PathParam() required this.holidayId});

  @override
  _EncodeParticipantHolidayScreenState createState() => _EncodeParticipantHolidayScreenState();
}

class _EncodeParticipantHolidayScreenState extends State<EncodeParticipantHolidayScreen> {

  @override
  void initState() {
    context.read<ParticipantBloc>().add(GetAllParticipantNotYetInHoliday(holidayId: widget.holidayId));
    super.initState();
  }

  List<Participant> participantsBase = [];

  final List<Participant> _selectedParticipants = [];

  void _selectParticipant(Participant participant) {
    setState(() {
      participantsBase.remove(participant);
      _selectedParticipants.add(participant);
    });
  }

  void _deselectParticipant(Participant participant) {
    setState(() {
      _selectedParticipants.remove(participant);
      participantsBase.add(participant);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF1E3A8A),
          title: const Text("Encoder un participant"),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: MySearch(
                    participants: participantsBase,
                    onParticipantSelected: _selectParticipant,
                  ),
                );
              },
            )
          ],
        ),

        body: _buildEncodeParticipant(),
    );
}
  Widget _buildEncodeParticipant() {
    return Container(
      margin: const EdgeInsets.all(8.0),
        child: MultiBlocListener(
          listeners: [
            BlocListener<ParticipantBloc, ParticipantState>(
              listener: (context, state) {
                if (state.status == ParticipantStateStatus.error) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentMaterialBanner()
                    ..showMaterialBanner(CustomMessage(message: state.errorMessage).build(context));
                }
              },
            ),
            BlocListener<InvitationBloc, InvitationState>(
              listener: (context, state) {
                if (state.status == InvitationStateStatus.error) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentMaterialBanner()
                    ..showMaterialBanner(CustomMessage(message: state.errorMessage!).build(context));
                }
                if (state.status == InvitationStateStatus.sent) {
                  context.router.pop();
                }
              },
            ),
          ],
          child: BlocBuilder<ParticipantBloc, ParticipantState>(
                builder: (context, state) {
                  if (state.status == ParticipantStateStatus.initial || state.status == ParticipantStateStatus.loading) {
                    return const LoadingProgressor();
                  } else if (state.status == ParticipantStateStatus.loaded) {
                    final participants = state.participantsList ?? [];
                    participantsBase = participants;
                    return _buildEncodeParticipantInfo(context, participants);
                  } else {
                    return Container();
                  }
                },
          ),
        ),
    );
  }


  Widget _buildEncodeParticipantInfo(BuildContext context, List<Participant> participants) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculez les largeurs des colonnes en pourcentage
    final cardWith = screenWidth * 0.95;
    final tableHeight = screenHeight * 0.25;

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            buildParticipantBeingAdded(
              tableHeight: tableHeight,
              cardWith: cardWith,
              selectedParticipants: _selectedParticipants,
              onDeselectParticipant: _deselectParticipant,
            ),

            const SizedBox(
              height: 10,
            ),
            buildParticipantAddable(
              tableHeight: tableHeight,
              cardWith: cardWith,
              participantsBase: participantsBase,
              onParticipantSelected: _selectParticipant,
            ),

            Container(
              margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Center(
                child: ElevatedButton.icon(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.only(left: 10, right: 10),
                    ),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0xFF1E3A8A);
                        }
                        return const Color(0xFF1E3A8A);
                      },
                    ),
                  ),
                  icon: const Icon(Icons.add),
                  label: const Text('Ajouter'),
                  onPressed: () {
                    context.read<InvitationBloc>().add(CreateInvitations(participants: _selectedParticipants, holidayId: widget.holidayId));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


