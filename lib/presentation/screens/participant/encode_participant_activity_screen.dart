import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holiday_mobile/data/models/participant/participant.dart';
import 'package:holiday_mobile/logic/blocs/activity_bloc/activity_bloc.dart';
import 'package:holiday_mobile/presentation/widgets/participant/addable_participant.dart';
import 'package:holiday_mobile/presentation/widgets/participant/my_search.dart';
import 'package:holiday_mobile/presentation/widgets/common/custom_message.dart';
import 'package:holiday_mobile/presentation/widgets/common/progress_loading_widget.dart';
import 'package:holiday_mobile/presentation/widgets/participant/participant_being_added.dart';
import '../../widgets/participant/participant_card.dart';



@RoutePage()
class EncodeParticipantActivityScreen extends StatefulWidget {
  final String activityId;

  const EncodeParticipantActivityScreen({super.key, @PathParam() required this.activityId});

  @override
  _EncodeParticipantActivityScreenState createState() => _EncodeParticipantActivityScreenState();
}

class _EncodeParticipantActivityScreenState extends State<EncodeParticipantActivityScreen> {

  @override
  void initState() {
    //Récupère les participants qui sont déjà dans la vacances et ceux qui ne le sont pas encore.
    context.read<ActivityBloc>().add(InitParticipates(activityId: widget.activityId));
    super.initState();
  }

  List<Participant> _participantsInActivity = [];
  List<Participant> participantsNotYetInActivity = [];
  final List<Participant> _selectedParticipants = [];

  //Gestion en interne des participants
  void _selectParticipant(Participant participant) {
    setState(() {
      participantsNotYetInActivity.remove(participant);
      _selectedParticipants.add(participant);
    });
  }

  void _deselectParticipant(Participant participant) {
    setState(() {
      _selectedParticipants.remove(participant);
      participantsNotYetInActivity.add(participant);
    });
  }

  void _deleteParticipant(Participant participant) {
    context.read<ActivityBloc>().add(DeleteParticipate(activityId: widget.activityId, participantId: participant.id!));

    setState(() {
      _participantsInActivity.remove(participant);

      if (participant != null) {
        participantsNotYetInActivity.add(participant);
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
                  participants: participantsNotYetInActivity,
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
          BlocListener<ActivityBloc, ActivityState>(
            listener: (context, state) {
              if (state.status == ActivityStateStatus.error) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentMaterialBanner()
                  ..showMaterialBanner(CustomMessage(message: state.errorMessage!).build(context));
              }
              if (state.status == ActivityStateStatus.sent) {
                context.router.pop();
              }
            },
          ),
        ],
        child: BlocBuilder<ActivityBloc, ActivityState>(
          builder: (context, state) {
            if (state.status == ActivityStateStatus.initial || state.status == ActivityStateStatus.loading) {
              return const LoadingProgressor();
            } else if (state.status == ActivityStateStatus.loaded) {
              participantsNotYetInActivity = state.participantsNotYetInActivity ?? [];
              _participantsInActivity = state.participantsInActivity ?? [];
              return _buildEncodeParticipantInfo(context);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }


  Widget _buildEncodeParticipantInfo(BuildContext context) {
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
             Container(
              margin: const EdgeInsets.only(top: 15),
              child: ParticipantCard(
                nameColumnWidth: nameColumnWidth,
                emailColumnWidth: emailColumnWidth,
                buttonColumnWidth: buttonColumnWidth,
                tableParticipantsHeight: tableParticipantHeight,
                title: 'Participant(s) déjà ajouté(s)',
                icon: Icons.add,
                participantInActivity: _participantsInActivity,
                elementId: widget.activityId,
                onDeleteParticipant: _deleteParticipant,
                isPublish: false,
              ),
            ),

              const SizedBox(
                height: 10,
              ),


              buildParticipantAddable(
                tableHeight: tableHeight,
                cardWith: cardWith,
                participantsBase: participantsNotYetInActivity,
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
                        context.read<ActivityBloc>().add(CreateParticipates(participants: _selectedParticipants, activityId: widget.activityId));
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
