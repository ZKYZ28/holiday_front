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
  final String participantId;

  const InvitationsScreen({
    Key? key,
    @PathParam() required this.participantId,
  }) : super(key: key);

  @override
  _InvitationsScreenState createState() => _InvitationsScreenState();
}

class _InvitationsScreenState extends State<InvitationsScreen> {
  //Création du bloc
  final InvitationBloc _invitationBloc = InvitationBloc();


  @override
  void initState() {
    _invitationBloc.add(const GetAllInvitationsByParticipant(
      //TODO CHANGER UNE FOIS QU'ON SERA CONNECTE
        participantId: 'f70fefe8-61b2-43f6-8203-c30e9a17d2b3'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E3A8A),
        title: const Text('Invitation(s)'),
      ),
      body: _buildListInvitations()
    );
  }

  Widget _buildListInvitations(){
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _invitationBloc,
        child: BlocListener<InvitationBloc, InvitationState>(
          listener: (context, state) {
            if (state is InvitationError) {
              ScaffoldMessenger.of(context)
                ..hideCurrentMaterialBanner()
                ..showMaterialBanner(CustomMessage(message: state.message!).build(context));
            }
          },
          child: BlocBuilder<InvitationBloc, InvitationState>(
            builder: (context, state) {
              if (state is InvitationInitial || state is InvitationLoading) {
                return const LoadingProgressor();
              } else if (state is InvitationLoaded) {
                final invitations = state.invitationsList ?? [];
                return _buildInvitations(context, invitations!, _invitationBloc);
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInvitations(BuildContext context, List<Invitation> invitations, InvitationBloc invitationBloc) {
    return ListView.builder(
      itemCount: invitations.length,
      itemBuilder: (context, index) {
        final invitation = invitations[index];
        return InivtationCard(invitation: invitation, invitationBloc: invitationBloc);
      },
    );
  }

}