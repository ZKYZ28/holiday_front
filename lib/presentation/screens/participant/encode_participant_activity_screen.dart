import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holiday_mobile/data/models/participant/participant.dart';
import 'package:holiday_mobile/logic/blocs/participant_bloc/participant_bloc.dart';
import 'package:holiday_mobile/presentation/widgets/participant/addable_participant.dart';
import 'package:holiday_mobile/presentation/widgets/participant/my_search.dart';
import 'package:holiday_mobile/presentation/widgets/common/custom_message.dart';
import 'package:holiday_mobile/presentation/widgets/common/progress_loading_widget.dart';
import 'package:holiday_mobile/data/models/participate/participate.dart';
import 'package:holiday_mobile/presentation/widgets/participant/participant_being_added.dart';
import '../../../logic/blocs/participate_bloc/participate_bloc.dart';
import '../../widgets/participant/participant_card.dart';



@RoutePage()
class EncodeParticipantActivityScreen extends StatefulWidget {
  final String activityId;

  const EncodeParticipantActivityScreen({super.key, @PathParam() required this.activityId});

  @override
  _EncodeParticipantActivityScreenState createState() => _EncodeParticipantActivityScreenState();
}

class _EncodeParticipantActivityScreenState extends State<EncodeParticipantActivityScreen> {
  //Création des blocs
  final ParticipateBloc _participateBloc = ParticipateBloc();

  @override
  void initState() {
    context.read<ParticipantBloc>().add(GetAllParticipantNotYetInActivity(activityId: widget.activityId));
    _participateBloc.add(GetAllParticipatesByActivity(activityId: widget.activityId));
    super.initState();
  }

  List<Participate> _participates = [];
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

  void _deleteParticipant(Participate participate) {
    _participateBloc.add(DeleteParticipate(participateId: participate.id!));

    setState(() {
      _participates.remove(participate);

      if (participate.participant != null) {
        participantsBase.add(participate.participant!);
      }
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
      child: BlocProvider(
          create: (_) => _participateBloc,
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
              BlocListener<ParticipateBloc, ParticipateState>(
                listener: (context, state) {
                  if (state.status == ParticipateStateStatus.error) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentMaterialBanner()
                      ..showMaterialBanner(CustomMessage(message: state.errorMessage).build(context));
                  }
                  if (state.status == ParticipateStateStatus.sent) {
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
      ),
    );
  }


  Widget _buildEncodeParticipantInfo(BuildContext context, List<Participant> participants) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculez les largeurs des colonnes en pourcentage
    final cardWith = screenWidth * 0.95;
    final tableHeight = screenHeight * 0.25;

    final nameColumnWidth = screenWidth * 0.20;
    final emailColumnWidth = screenWidth * 0.45;
    final buttonColumnWidth = screenWidth * 0.20;
    final tableParticipantHeight = screenHeight * 0.30;

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<ParticipateBloc, ParticipateState>(
              builder: (context, state) {
                if (state.status == ParticipateStateStatus.initial || state.status == ParticipateStateStatus.loading) {
                  return const LoadingProgressor();
                } else if (state.status == ParticipateStateStatus.loaded) {
                  _participates = state.participatesList ?? [];

                  return Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: ParticipantCard(
                      nameColumnWidth: nameColumnWidth,
                      emailColumnWidth: emailColumnWidth,
                      buttonColumnWidth: buttonColumnWidth,
                      tableParticipantsHeight: tableParticipantHeight,
                      title: 'Participant(s) déjà ajouté(s)',
                      icon: Icons.add,
                      participates: _participates,
                      elementId: widget.activityId,
                      onDeleteParticipate: _deleteParticipant,
                    ),
                  );
                } else {
                  return Container();
                }
              },
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

            buildParticipantBeingAdded(
              tableHeight: tableHeight,
              cardWith: cardWith,
              selectedParticipants: _selectedParticipants,
              onDeselectParticipant: _deselectParticipant,
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
                      _participateBloc.add(CreateParticipates(participants: _selectedParticipants, activityId: widget.activityId));
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
