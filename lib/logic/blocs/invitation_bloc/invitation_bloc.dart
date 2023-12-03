import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holiday_mobile/data/exceptions/api_exception.dart';
import 'package:holiday_mobile/data/models/invitation/invitation.dart';
import 'package:holiday_mobile/data/models/participant/participant.dart';
import 'package:holiday_mobile/data/repositories/authentification_api_repository.dart';
import 'package:holiday_mobile/data/repositories/invtation_api_repository.dart';

part 'invitation_event.dart';
part 'invitation_state.dart';

class InvitationBloc extends Bloc<InvitationEvent, InvitationState> {
  final InvitationApiRepository invitationApiRepository = InvitationApiRepository();

    InvitationBloc() : super(const InvitationState()) {

    on<CreateInvitations>((CreateInvitations event, Emitter<InvitationState> emit) async {
      try {
        final List<Participant> participants = event.participants;
        final holidayId = event.holidayId;

        await invitationApiRepository.createInvitations(participants, holidayId);

        emit(state.copyWith(status: InvitationStateStatus.sent));
      } on ApiException catch (e) {
        emit(state.copyWith(status: InvitationStateStatus.error,errorMessage : e.toString()));
      }
    });

    on<GetAllInvitationsByParticipant>((GetAllInvitationsByParticipant event, Emitter<InvitationState> emit) async {
      try {
        emit(state.copyWith(status: InvitationStateStatus.loading));

        final invitationsList = await invitationApiRepository
            .getAllInvitationsByParticipant();

        emit(state.copyWith(status: InvitationStateStatus.loaded, invitationsList: invitationsList));

      } on ApiException catch (e) {
        emit(state.copyWith(status: InvitationStateStatus.error, errorMessage: e.toString()));
      }
    });

    on<AcceptInvitation>((AcceptInvitation event, Emitter<InvitationState> emit) async {
      try {
        final invitationId = event.invitationId;

        await invitationApiRepository.acceptInvitation(invitationId);

        emit(state.copyWith(status: InvitationStateStatus.accepted));
      } on ApiException catch (e) {
        emit(state.copyWith(status: InvitationStateStatus.error, errorMessage: e.toString()));
      }
    });

    on<RefuseInvitation>((RefuseInvitation event, Emitter<InvitationState> emit) async {
      try {
        final invitationId = event.invitationId;

        await invitationApiRepository.refuseInvitation(invitationId);

      } on ApiException catch (e) {
        emit(state.copyWith(status: InvitationStateStatus.error, errorMessage: e.toString()));
      }
    });
  }
}