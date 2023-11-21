import 'package:flutter/material.dart';
import 'package:holiday_mobile/data/models/participant/participant.dart';

Widget buildParticipantBeingAdded({
  required double tableHeight,
  required double cardWith,
  required List<Participant> selectedParticipants,
  required Function(Participant) onDeselectParticipant,
}) {
  return Container(
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
                itemCount: selectedParticipants.length,
                itemBuilder: (context, index) {
                  final participant = selectedParticipants[index];
                  return Card(
                    color: Colors.grey[100],
                    child: ListTile(
                      title: Text('${participant.firstName} (${participant.email})'),
                      trailing: const Icon(Icons.delete, color: Colors.red),
                      onTap: () {
                        onDeselectParticipant(participant);
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
  );
}