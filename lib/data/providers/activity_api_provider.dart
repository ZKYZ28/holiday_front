import 'package:dio/dio.dart';
import 'package:holiday_mobile/data/exceptions/api_exception.dart';
import 'package:holiday_mobile/data/models/activity/activity.dart';

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

  Future<void> deleteActivity(Activity activity) async {
    try {
      //Conversion en JSON
      final activityJson = activity.toJson();

      await _dio.post('v1/Activity/delete', data: activityJson);
    } on DioException catch (e){
      throw ApiException(e.response?.data, e);

    } catch (e, stacktrace) {
      throw ApiException("Une erreur s'est produite lors de la récupération de votre activité", stacktrace);
    }
  }
}