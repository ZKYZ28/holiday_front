import 'package:flutter/material.dart';
import 'package:holiday_mobile/data/models/invitation/invitation.dart';
import 'package:holiday_mobile/logic/blocs/invitation_bloc/invitation_bloc.dart';
import 'package:intl/intl.dart';

class InivtationCard extends StatelessWidget {
  final Invitation invitation;
  final InvitationBloc invitationBloc;

  const InivtationCard({super.key, required this.invitation, required this.invitationBloc});

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormatFull = DateFormat('dd-MM-yyyy');

    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Titre
          Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              children: [
                Text(
                  '${invitation.holiday?.name}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),
                ),

                Text(
                  dateFormatFull.format(DateTime.parse(invitation.holiday!.startDate)),
                  style: const TextStyle(
                      fontSize: 12
                  ),
                ),
              ],
            ),
          ),

          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.check, color: Colors.green),
                onPressed: () {
                  invitationBloc.add(AcceptInvitation(invitation: invitation));
                },
              ),

              IconButton(
                icon: const Icon(Icons.close, color: Colors.red),
                onPressed: () {
                  invitationBloc.add(RefuseInvitation(invitation: invitation));
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}