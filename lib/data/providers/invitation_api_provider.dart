import 'package:dio/dio.dart';
import 'package:holiday_mobile/data/exceptions/api_exception.dart';
import 'package:holiday_mobile/data/models/invitation/invitation.dart';
import 'package:holiday_mobile/data/models/participant/participant.dart';
import 'package:holiday_mobile/data/providers/dio/dio_instance.dart';

class InvitationsApiProvider{
  final Dio _dio = DioService().dio;


  Future<void> createInvitations(List<Participant> participants, String holidayId) async {
    try {

      //Création des invitations
      List<Invitation> invitations = Invitation.createInvitations(participants, holidayId);

      //Conversion en JSON
      List<Map<String, dynamic>> invitationsJsonList = Invitation.invitationsToJsonList(invitations);

      await _dio.post('v1/invitation', data: invitationsJsonList);
    } on DioException catch (e){
      throw ApiException(e.response?.data, e);

    } catch (e, stacktrace) {
      throw ApiException("Une erreur s'est produite lors de la récupération des vacances publiées", stacktrace);
    }
  }


  Future<List<Invitation>> fetchAllInvitationsByParticipant(String participantId) async {
    try {
      final response = await _dio.get('v1/invitation/all/$participantId');

      List<Invitation> invitations = (response.data as List<dynamic>).map((index) => Invitation.fromJson(index as Map<String, dynamic>)).toList();

      return invitations;
    } on DioException catch (e){
      throw ApiException(e.response?.data, e);

    } catch (e, stacktrace) {
      throw ApiException("Une erreur s'est produite lors de la récupération des vacances publiées", stacktrace);
    }
  }

  Future<void> acceptInvitation(Invitation invitation) async {
    try {
      //Conversion en JSON
      final invitationJson = invitation.toJson();

      await _dio.post('v1/invitation/accept', data: invitationJson);
    } on DioException catch (e){
      throw ApiException(e.response?.data, e);

    } catch (e, stacktrace) {
      throw ApiException("Une erreur s'est produite lors de la récupération des vacances publiées", stacktrace);
    }
  }

  Future<void> refuseInvitation(Invitation invitation) async {
    try {
      //Conversion en JSON
      final invitationJson = invitation.toJson();

      await _dio.post('v1/invitation/refuse', data: invitationJson);
    } on DioException catch (e){
      throw ApiException(e.response?.data, e);

    } catch (e, stacktrace) {
      throw ApiException("Une erreur s'est produite lors de la récupération des vacances publiées", stacktrace);
    }
  }
}