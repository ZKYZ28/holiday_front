import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holiday_mobile/data/models/invitation/invitation.dart';
import 'package:holiday_mobile/logic/blocs/invitation_bloc/invitation_bloc.dart';
import 'package:intl/intl.dart';

class InvitationCard extends StatelessWidget {
  final Invitation invitation;
  final VoidCallback onClick;

  const InvitationCard({super.key, required this.invitation, required this.onClick});

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
                  context.read<InvitationBloc>().add(AcceptInvitation(invitation: invitation));
                  onClick();
                },
              ),

              IconButton(
                icon: const Icon(Icons.close, color: Colors.red),
                onPressed: () {
                  context.read<InvitationBloc>().add(RefuseInvitation(invitation: invitation));
                  onClick();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}