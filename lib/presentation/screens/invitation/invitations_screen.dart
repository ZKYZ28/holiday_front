import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holiday_mobile/data/models/invitation/invitation.dart';
import 'package:holiday_mobile/logic/blocs/invitation_bloc/invitation_bloc.dart';
import 'package:holiday_mobile/presentation/widgets/common/custom_message.dart';
import 'package:holiday_mobile/presentation/widgets/common/progress_loading_widget.dart';
import 'package:holiday_mobile/presentation/widgets/invitations/invitation_card.dart';

@RoutePage()
class InvitationsScreen extends StatefulWidget {

  const InvitationsScreen({
    super.key
  });

  @override
  _InvitationsScreenState createState() => _InvitationsScreenState();
}

class _InvitationsScreenState extends State<InvitationsScreen> {
  //Création du bloc
  List<Invitation> invitations = [];

  @override
  void initState() {
    context.read<InvitationBloc>().add(GetAllInvitationsByParticipant());
    super.initState();
  }

  void _removeInvitation(Invitation invitation) {
    setState(() {
      invitations.remove(invitation);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E3A8A),
        title: const Text('Invitations'),
      ),
      body: _buildListInvitations()
    );
  }

  Widget _buildListInvitations(){
    return Container(
      margin: const EdgeInsets.all(8.0),

        child: BlocListener<InvitationBloc, InvitationState>(
          listener: (context, state) {
            if (state.status == InvitationStateStatus.error) {
              ScaffoldMessenger.of(context)
                ..hideCurrentMaterialBanner()
                ..showMaterialBanner(CustomMessage(message: state.errorMessage!).build(context));
            }
          },
          child: BlocBuilder<InvitationBloc, InvitationState>(
            builder: (context, state) {
              if (state.status == InvitationStateStatus.initial || state.status == InvitationStateStatus.loading) {
                return const LoadingProgressor();
              } else if (state.status == InvitationStateStatus.loaded) {
                invitations = state.invitationsList ?? [];
                return _buildInvitations(context, invitations);
              } else {
                return Container();
              }
            },
          ),
        ),
    );
  }

  Widget _buildInvitations(BuildContext context, List<Invitation> invitations) {
    return ListView.builder(
      itemCount: invitations.length,
      itemBuilder: (context, index) {
        final invitation = invitations[index];
        return InvitationCard(
          invitation: invitation,
          onClick: () => _removeInvitation(invitation),
        );
      },
    );
  }

}