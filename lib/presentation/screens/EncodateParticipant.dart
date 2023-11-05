import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:holiday_mobile/presentation/screens/myholiday_screen.dart';

class Participant {
  final int id;
  final String nom;
  final String email;

  Participant({required this.id, required this.nom, required this.email});
}
@RoutePage()
class EncodeParticipant extends StatefulWidget {
  const EncodeParticipant({super.key});

  @override
  State<EncodeParticipant> createState() => _EncodeParticipantState();
}

class _EncodeParticipantState extends State<EncodeParticipant> {

  List<Participant> _availableParticipants = [
    Participant(id: 1, nom: 'Mermoud', email: 'mermoud.dupuis@gmail.com'),
    Participant(id: 2, nom: 'Jean', email: 'jean.dupuis@gmail.com'),
    Participant(id: 3, nom: 'Jacques', email: 'Jacques.dupuis@gmail.com'),
    Participant(id: 4, nom: 'Roger', email: 'roger.dupuis@gmail.com'),
    Participant(id: 5, nom: 'John', email: 'john.dupuis@gmail.com'),
    Participant(id: 6, nom: 'Ferdinand', email: 'ferdinand.dupuis@gmail.com'),
  ];

  List<Participant> _selectedParticipants = [];

  void _selectParticipant(Participant participant) {
    setState(() {
      _availableParticipants.remove(participant);
      _selectedParticipants.add(participant);
    });
  }

  void _deselectParticipant(Participant participant) {
    setState(() {
      _selectedParticipants.remove(participant);
      _availableParticipants.add(participant);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculez les largeurs des colonnes en pourcentage
    final cardWith = screenWidth * 0.95;
    final tableWidth = screenWidth * 0.85;
    final tableHeight = screenHeight * 0.25;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF1E3A8A),
          title: Text("Encoder un participant"),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: MySearch(participants: _availableParticipants, onParticipantSelected : _selectParticipant),
                ).then((selectedParticipant) {
                  if (selectedParticipant != null) {
                    print('Selected participants: ${selectedParticipant.nom}');
                  }
                });
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(maxHeight: tableHeight),
                  width: cardWith,
                  child: Card(
                    elevation: 5,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Text(
                              'Participant(s) en cours d\'ajout : ',
                              style: const TextStyle(
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
                                        title: Text(
                                            '${participant.nom} (${participant.email})'),
                                        trailing: Icon(Icons.delete,
                                            color: Colors.red),
                                        onTap: () {
                                          // Mettre le participant dans les participants ajoutables
                                          // sous forme de listTile
                                          _deselectParticipant(participant);
                                        },
                                      ),
                                    );
                                  })),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  constraints: BoxConstraints(maxHeight: tableHeight),
                  width: cardWith,
                  child: Card(
                    elevation: 5,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Text(
                              'Participant(s) ajoutable(s) : ',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E3A8A),
                              ),
                            ),
                          ),
                          Expanded(
                              child: ListView.builder(
                                  itemCount: _availableParticipants.length,
                                  itemBuilder: (context, index) {
                                    final participant = _availableParticipants[index];
                                    return Card(
                                      color: Colors.grey[100],
                                      child: ListTile(
                                        title: Text(
                                            '${participant.nom} (${participant.email})'),
                                        trailing: Icon(Icons.add),
                                        onTap: () {
                                          // Mettre le participant dans les participants ajoutables
                                          // sous forme de listTile
                                          _selectParticipant(participant);
                                        },
                                      ),
                                    );
                                  })),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Center(
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            EdgeInsets.only(left: 10, right: 10)),
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Color(0xFF1E3A8A);
                            }
                            return Color(0xFF1E3A8A);
                          },
                        ),
                      ),
                      icon: const Icon(Icons.add),
                      label: const Text('Ajouter'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (_, __, ___) => MyHolidayPage()));
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
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
      icon: Icon(Icons.arrow_back));

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
              participant.nom.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    return ListView.builder(
      itemCount: filteredParticipants.length,
      itemBuilder: (context, index) {
        final participant = filteredParticipants[index];

        return ListTile(
          title: Text('${participant.nom} (${participant.email})'),
          onTap: () {
            query = participant.nom;
            showResults(context);
            onParticipantSelected(participant);
            close(context, participant);
          },
        );
      },
    );
  }
}
