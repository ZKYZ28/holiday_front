import 'package:dio/dio.dart';
import 'package:holiday_mobile/data/exceptions/api_exception.dart';
import 'package:holiday_mobile/data/models/activity/activity.dart';
import 'package:holiday_mobile/data/models/participant/participant.dart';
import 'package:holiday_mobile/data/providers/data/ActivityData.dart';
import 'package:logger/logger.dart';
import 'dio/dio_instance.dart';

class ActivityApiProvider{

  final Dio _dio = DioService().dio;
  var logger = Logger();


  Future<Activity> fetchActivityById(String activityId) async {
    try {
      Response response = await _dio.get('v1/Activity/$activityId');

      // conversion list
      final activity = Activity.fromJson(response.data);

      logger.i("Activité $activityId récupérée avec succès.");
      return activity;

    } on DioException catch (e){
      throw ApiException(e.response?.data, e);

    } catch (e, stacktrace) {
      logger.e("Erreur lors de la récupération de l'activité $activityId.");
      throw ApiException("Une erreur s'est produite lors de la récupération de votre activité", stacktrace);
    }
  }

  Future<void> deleteActivity(String activityId) async {
    try {
      await _dio.delete('v1/Activity/$activityId');
      logger.i("Activité $activityId supprimée avec succès.");

    } on DioException catch (e){
      logger.e("Erreur lors de la suppression de l'activité $activityId.");
      throw ApiException(e.response?.data, e);

    } catch (e, stacktrace) {
      logger.e("Erreur lors de la suppression de l'activité $activityId.");
      throw ApiException("Une erreur s'est produite lors de la suppression de votre activité", stacktrace);
    }
  }

  Future<void> createActivity(ActivityData activityData) async {
    try {
      final formDataMap = {
        'name': activityData.name,
        'description': activityData.description,
        'price' : activityData.price.toString().replaceAll('.', ','),
        'startDate': activityData.startDate.toIso8601String(),
        'endDate': activityData.endDate.toIso8601String(),
        'location.street': activityData.locationData.street,
        'location.number': activityData.locationData.numberBox,
        'location.locality': activityData.locationData.locality,
        'location.postalCode': activityData.locationData.postalCode,
        'location.country': activityData.locationData.country,
        'holidayId': activityData.holidayId,
      };
      final formData = FormData.fromMap(formDataMap);

      // Ajouter le fichier seulement s'il n'est pas null (comme en web)
      if (activityData.file != null) {
        formData.files.add(MapEntry(
            'UploadedActivityPicture',
            await MultipartFile.fromFile(activityData.file!.path),
        ));
      }
      await _dio.post('v1/activity/', data : formData);
      logger.i("Activité créée avec succès.");

    } on DioException catch (e){
      logger.i("Erreur lors de la création de l'activité");
      throw ApiException(e.response?.data, e);

    } catch (e, stacktrace) {
      logger.i("Erreur lors de la création de l'activité");
      throw ApiException("Une erreur s'est produite lors de la création de votre activité", stacktrace);
    }
  }

  Future<void> updateActivity(ActivityData activityData) async {
    try {
      final formDataMap = {
        'name': activityData.name,
        'description': activityData.description,
        'price' : activityData.price.toString().replaceAll('.', ','),
        'startDate': activityData.startDate.toIso8601String(),
        'endDate': activityData.endDate.toIso8601String(),
        'location.id' : activityData.locationData.locationId,
        'location.street': activityData.locationData.street,
        'location.number': activityData.locationData.numberBox,
        'location.locality': activityData.locationData.locality,
        'location.postalCode': activityData.locationData.postalCode,
        'location.country': activityData.locationData.country,
        'holidayId': activityData.holidayId,
        'deleteImage' : activityData.deleteImage,
        'initialPath' : activityData.initialPath
      };
      final formData = FormData.fromMap(formDataMap);

      // Ajouter le fichier seulement s'il n'est pas null (comme en web)
      if (activityData.file != null) {
        formData.files.add(MapEntry(
          'UploadedActivityPicture',
          await MultipartFile.fromFile(activityData.file!.path),
        ));
      }
      // TODO : enelver le create mais peut-être déjà fait dans le refactor ?
      await _dio.put('v1/activity/${activityData.activityId}', data : formData);
      logger.i("Activité ${activityData.activityId} mise à jour avec succès.");

    } on DioException catch (e){
      logger.i("Errur lors de la mise à jour de l'activité ${activityData.activityId}.");
      throw ApiException(e.response?.data, e);

    } catch (e, stacktrace) {
      logger.i("Errur lors de la mise à jour de l'activité ${activityData.activityId}.");
      throw ApiException("Une erreur s'est produite lors de la mise à jour de votre activité.", stacktrace);
    }
  }

  Future<void> deleteParticipate(String activityId, String participantId) async {
    try {
      await _dio.delete('v1/activity/$activityId/participant/$participantId');
      logger.i("Suppression de la participation du participant $participantId à l'activité $activityId réalisée avec succès.");

    } on DioException catch (e){
      logger.i("Erreur lors de la suppression de la participation du participant $participantId à l'activité $activityId.");
      throw ApiException(e.response?.data, e);

    } catch (e, stacktrace) {
      logger.i("Erreur lors de la suppression de la participation du participant $participantId à l'activité $activityId.");
      throw ApiException("Une erreur s'est produite lors de la suppression de la participation à l'activité.", stacktrace);
    }
  }

  Future<List<Participant>> getParticipantsByActivity(String activityId, bool isParticipated) async {
    try {
      final response = await _dio.get('v1/activity/$activityId/participant',
          queryParameters: {
            'isParticipated' : isParticipated
          });

      List<Participant> participants = (response.data as List<dynamic>).map((index) => Participant.fromJson(index as Map<String, dynamic>)).toList();

      logger.i("Récupération de tous les participants de l'activité $activityId réalisée avec succès.");
      return participants;

    } on DioException catch (e){
      logger.i("Erreur lors de la récupération de tous les participations de l'activité $activityId.");
      throw ApiException(e.response?.data, e);

    } catch (e, stacktrace) {
      logger.i("Erreur lors de la récupération de tous les participations de l'activité $activityId.");
      throw ApiException("Une erreur s'est produite lors de la récupération des participants de l'activité.", stacktrace);
    }
  }

  Future<void> createParticipate(String activityId, String participantId) async {
    try {

      await _dio.post('v1/activity/$activityId/participant/$participantId');
      logger.i("Création de participations à une activité réalisée avec succès.");

    } on DioException catch (e){
      logger.e("Erreur lors de la création de participations à une activité.");
      throw ApiException(e.response?.data, e);

    } catch (e, stacktrace) {
      logger.e("Erreur lors de la création de participations à une activité.");
      throw ApiException("Une erreur s'est produite lors de la création d'une participation à l'activité.", stacktrace);
    }
  }

}