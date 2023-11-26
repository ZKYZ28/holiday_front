import 'package:dio/dio.dart';
import 'package:holiday_mobile/data/exceptions/api_exception.dart';
import 'package:holiday_mobile/data/models/activity/activity.dart';
import 'package:holiday_mobile/data/providers/data/ActivityData.dart';

import 'dio/dio_instance.dart';

class ActivityApiProvider{

  final Dio _dio = DioService().dio;


  Future<Activity> fetchActivityById(String holidayId) async {
    try {
      Response response = await _dio.get('v1/Activity/$holidayId');

      // conversion list
      final activity = Activity.fromJson(response.data);

      return activity;

    } on DioException catch (e){
      throw ApiException(e.response?.data, e);

    } catch (e, stacktrace) {
      throw ApiException("Une erreur s'est produite lors de la récupération de votre activité", stacktrace);
    }
  }

  Future<void> deleteActivity(String activityId) async {
    try {
      await _dio.delete('v1/Activity/$activityId');

    } on DioException catch (e){
      throw ApiException(e.response?.data, e);

    } catch (e, stacktrace) {
      throw ApiException("Une erreur s'est produite lors de la récupération de votre activité", stacktrace);
    }
  }

  Future<void> createActivity(ActivityData activityData) async {
    try {
      final formDataMap = {
        'name': activityData.name,
        'description': activityData.description,
        'price' : activityData.price,
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
    // TODO : enelver le create mais peut-être déjà fait dans le refactor ?
    Response response = await _dio.post('v1/activity/create', data : formData);
    print(response);
    } on DioException catch (e){
    throw ApiException(e.response?.data, e);

    } catch (e, stacktrace) {
    throw ApiException("Une erreur s'est produite lors de la création de votre vacance", stacktrace);
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
      Response response = await _dio.put('v1/activity/${activityData.activityId}', data : formData);
      print(response);
    } on DioException catch (e){
      throw ApiException(e.response?.data, e);

    } catch (e, stacktrace) {
      throw ApiException("Une erreur s'est produite lors de la création de votre vacance", stacktrace);
    }
  }
}