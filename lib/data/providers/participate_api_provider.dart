import 'package:dio/dio.dart';
import 'package:holiday_mobile/data/exceptions/api_exception.dart';
import 'package:holiday_mobile/data/models/participate/participate.dart';
import 'package:holiday_mobile/data/models/participant/participant.dart';

import 'dio/dio_instance.dart';

class ParticipateApiProvider{
  final Dio _dio = DioService().dio;

  Future<List<Participate>> getAllParticipatesByActivity(String activityId) async {
    try {
      final response = await _dio.get('v1/Participate/allByActivity/$activityId');

      List<Participate> participates = (response.data as List<dynamic>).map((index) => Participate.fromJson(index as Map<String, dynamic>)).toList();
      return participates;

    } on DioException catch (e){
      throw ApiException(e.response?.data, e);

    } catch (e, stacktrace) {
      throw ApiException("Une erreur s'est produite lors de la récupération des utilisateurs ajoutables à la vacances.", stacktrace);
    }
  }

  Future<void> createParticipates(List<Participant> participants, String holidayId) async {
    try {

      //Création des invitations
      List<Participate> invitations = Participate.createParticipates(participants, holidayId);

      //Conversion en JSON
      List<Map<String, dynamic>> invitationsJsonList = Participate.participatesToJsonList(invitations);

      await _dio.post('v1/participate', data: invitationsJsonList);
    } on DioException catch (e){
      throw ApiException(e.response?.data, e);

    } catch (e, stacktrace) {
      throw ApiException("Une erreur s'est produite lors de la récupération des vacances publiées", stacktrace);
    }
  }


  Future<void> deleteParticipate(Participate participate) async {
    try {
      //Conversion en JSON
      final participateJson = participate.toJson();

      await _dio.post('v1/Participate/delete', data: participateJson);
    } on DioException catch (e){
      throw ApiException(e.response?.data, e);

    } catch (e, stacktrace) {
      throw ApiException("Une erreur s'est produite lors de la récupération des vacances publiées", stacktrace);
    }
  }

}