import 'package:flutter/material.dart';
import 'package:holiday_mobile/data/models/participant/participant.dart';

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