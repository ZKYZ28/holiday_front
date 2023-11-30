import 'package:dio/dio.dart';
import 'package:holiday_mobile/data/exceptions/api_exception.dart';
import 'package:holiday_mobile/data/models/holiday/holiday.dart';
import 'package:holiday_mobile/data/models/participant/participant.dart';
import 'package:holiday_mobile/data/providers/dio/dio_instance.dart';

class ParticipantApiProvider{
  final Dio _dio = DioService().dio;


  Future<void> leaveHoliday(String holidayId) async {
    try {

      await _dio.delete('v1/holiday/$holidayId/leave');

    } on DioException catch (e){
      throw ApiException(e.response?.data, e);

    } catch (e, stacktrace) {
      throw ApiException("Une erreur s'est produite lorsque vous avez quitté la vacances.", stacktrace);
    }
  }

  Future<List<Participant>> getAllParticipantNotYetInHoliday(String holidayId, bool isParticipated) async {
    try {
      final response = await _dio.get('v1/invitation/participant/holiday/$holidayId',
      queryParameters: {
        'isParticipated' : isParticipated
      });

      List<Participant> participants = (response.data as List<dynamic>).map((index) => Participant.fromJson(index as Map<String, dynamic>)).toList();
      return participants;

    } on DioException catch (e){
      throw ApiException(e.response?.data, e);

    } catch (e, stacktrace) {
      throw ApiException("Une erreur s'est produite lors de la récupération des utilisateurs ajoutables à la vacances.", stacktrace);
    }
  }

  Future<List<Participant>> getAllParticipantNotYetInActivity(String activityId) async {
    try {
      final response = await _dio.get('v1/Participant/activity/$activityId');

      List<Participant> participants = (response.data as List<dynamic>).map((index) => Participant.fromJson(index as Map<String, dynamic>)).toList();
      return participants;

    } on DioException catch (e){
      throw ApiException(e.response?.data, e);

    } catch (e, stacktrace) {
      throw ApiException("Une erreur s'est produite lors de la récupération des utilisateurs ajoutables à la vacances.", stacktrace);
    }
  }
}