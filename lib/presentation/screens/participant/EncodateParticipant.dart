import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holiday_mobile/data/models/participant/participant.dart';
import 'package:holiday_mobile/logic/blocs/invitation_bloc/invitation_bloc.dart';
import 'package:holiday_mobile/logic/blocs/participant_bloc/participant_bloc.dart';
import 'package:holiday_mobile/presentation/widgets/common/custom_message.dart';
import 'package:holiday_mobile/presentation/widgets/common/progress_loading_widget.dart';



@RoutePage()
class EncodeParticipant extends StatefulWidget {
  final String holidayId;

  const EncodeParticipant({super.key, @PathParam() required this.holidayId});

  @override
  _EncodeParticipantState createState() => _EncodeParticipantState();
}

class _EncodeParticipantState extends State<EncodeParticipant> {
  //Création des blocs
  final ParticipantBloc _participantBloc = ParticipantBloc();
  final InvitationBloc _invitationBloc = InvitationBloc();

  @override
  void initState() {
    _participantBloc.add(GetAllParticipantNotYetInHoliday(holidayId: widget.holidayId));
    super.initState();
  }

  List<Participant> participantsBase = [];

  List<Participant> _selectedParticipants = [];

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
                ).then((selectedParticipant) {
                  if (selectedParticipant != null) {
                    print('Selected participant: ${selectedParticipant.nom}');
                  }
                });
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
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ParticipantBloc>(create: (_) => _participantBloc),
          BlocProvider<InvitationBloc>(create: (_) => _invitationBloc),
          // Ajoutez d'autres BlocProvider pour les blocs supplémentaires que vous souhaitez écouter
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<ParticipantBloc, ParticipantState>(
              listener: (context, state) {
                if (state is ParticipantError) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentMaterialBanner()
                    ..showMaterialBanner(CustomMessage(message: state.message!).build(context));
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
              },
            ),
          ],
          child: BlocBuilder<ParticipantBloc, ParticipantState>(
            builder: (context, state) {
              if (state is ParticipantInitial || state is ParticipantLoading) {
                return const LoadingProgressor();
              } else if (state is ParticipantLoaded) {
                final participants = state.participants ?? [];
                participantsBase = state.participants!;
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

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(maxHeight: tableHeight),
              width: cardWith,
              child: Card(
                elevation: 5,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text(
                          'Participant(s) en cours d\'ajout : ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E3A8A),
                          ),
                        ),
                      ),

                      Expanded(
                        child: ListView.builder(
                          itemCount: _selectedParticipants.length,
                          itemBuilder: (context, index) {
                            final participant = _selectedParticipants[index];
                            return Card(
                              color: Colors.grey[100],
                              child: ListTile(
                                title: Text('${participant.firstName} (${participant.email})'),
                                trailing: const Icon(Icons.delete, color: Colors.red),
                                onTap: () {
                                  _deselectParticipant(participant);
                                },
                              ),
                            );
                          },
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              constraints: BoxConstraints(maxHeight: tableHeight),
              width: cardWith,
              child: Card(
                elevation: 5,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text(
                          'Participant(s) ajoutable(s) : ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E3A8A),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: participantsBase.length,
                          itemBuilder: (context, index) {
                            final participant = participantsBase[index];
                            return Card(
                              color: Colors.grey[100],
                              child: ListTile(
                                title: Text('${participant.firstName} (${participant.email})'),
                                trailing: const Icon(Icons.add),
                                onTap: () {
                                  _selectParticipant(participant);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                    _invitationBloc.add(CreateInvitations(participants: _selectedParticipants, holidayId: widget.holidayId));
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

class MySearch extends SearchDelegate {
  final List<Participant> participants;
  final Function(Participant) onParticipantSelected;

  MySearch({required this.participants, required this.onParticipantSelected});

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () => close(context, null),
            icon: const Icon(Icons.clear))
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () {
        if (query.isEmpty) {
          close(context, null);
        } else {
          query = '';
        }
      },
      icon: const Icon(Icons.arrow_back));

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Card(
        child: ListTile(
          title: Text(query),
          onTap: () {
            // Pass back the selected suggestion
            close(context, query);
          },
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Participant> filteredParticipants = participants
        .where(
          (participant) =>
              participant.firstName.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    return ListView.builder(
      itemCount: filteredParticipants.length,
      itemBuilder: (context, index) {
        final participant = filteredParticipants[index];

        return ListTile(
          title: Text('${participant.firstName} (${participant.email})'),
          onTap: () {
            query = participant.firstName;
            showResults(context);
            onParticipantSelected(participant);
            close(context, participant);
          },
        );
      },
    );
  }
}
