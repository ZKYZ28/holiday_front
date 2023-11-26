import 'package:holiday_mobile/data/providers/data/HolidayData.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:holiday_mobile/data/exceptions/api_exception.dart';
import 'package:holiday_mobile/data/models/holiday/holiday.dart';
import 'package:holiday_mobile/data/providers/dio/dio_instance.dart';
import 'package:open_file/open_file.dart';

class HolidayApiProvider{

    final Dio _dio = DioService().dio;


    Future<List<Holiday>> fetchHolidayByParticipant(String participantId) async {
      try {
        Response response = await _dio.get('v1/Holiday/allByParticipant/$participantId');

        // conversion list
        List<Holiday> holidays = (response.data as List<dynamic>).map((index) => Holiday.fromJson(index as Map<String, dynamic>)).toList();

        return holidays;

      } on DioException catch (e){
        throw ApiException(e.response?.data, e);

      } catch (e, stacktrace) {
        throw ApiException("Une erreur s'est produite lors de la récupération des vacances publiées", stacktrace);
      }
    }

    Future<List<Holiday>> fetchHolidayPublished() async {
      try {
        Response response = await _dio.get('v1/Holiday/allPublished');

        // conversion list
        List<Holiday> holidays = (response.data as List<dynamic>).map((index) => Holiday.fromJson(index as Map<String, dynamic>)).toList();

        return holidays;

      } on DioException catch (e){
        throw ApiException(e.response?.data, e);

      } catch (e, stacktrace) {
        throw ApiException("Une erreur s'est produite lors de la récupération de vos vacances", stacktrace);
      }
    }

    Future<Holiday> fetchHoliday(String holidayId) async {
      try {
        Response response = await _dio.get('v1/Holiday/$holidayId');
        Holiday holiday = Holiday.fromJson(response.data);

        return holiday;

      } on DioException catch (e){
        throw ApiException(e.response?.data, e);

      } catch (e, stacktrace) {
        throw ApiException("Une erreur s'est produite lors de la récupération de vos vacances", stacktrace);
      }
    }

    Future<void> publishHoliday(Holiday holiday) async {
      try {
        final holidayJson = holiday.toJson();

        await _dio.post('v1/Holiday/publish', data: holidayJson);

      } on DioException catch (e){
        throw ApiException(e.response?.data, e);

      } catch (e, stacktrace) {
        throw ApiException("Une erreur s'est produite lors de la publication de votre vacances", stacktrace);
      }
    }

    Future<void> deleteHoliday(Holiday holiday) async {
      try {
        final holidayJson = holiday.toJson();

        await _dio.post('v1/Holiday/delete', data: holidayJson);

      } on DioException catch (e){
        throw ApiException(e.response?.data, e);

      } catch (e, stacktrace) {
        throw ApiException("Une erreur s'est produite lors de la suppression de votre vacances", stacktrace);
      }
    }

    Future<void> exportHolidayToIcs(String holidayId) async {
      try {
        String filePath = '${(await getTemporaryDirectory()).path}/activity.ics';

        await _dio.download(
          'v1/Holiday/export/$holidayId',
          filePath,
        );

        OpenFile.open(filePath);

      } on DioException catch (e){
        throw ApiException(e.response?.data, e);

      } catch (e, stacktrace) {
        throw ApiException("Une erreur s'est produite lors de l'exportation de votre vacance", stacktrace);
      }
    }

  Future<void> createHoliday(HolidayData holidayData) async {
      try {
        final formDataMap = {
          'name': holidayData.name,
          'description': holidayData.description,
          'startDate': holidayData.startDate.toIso8601String(),
          'endDate': holidayData.endDate.toIso8601String(),
          'location.street': holidayData.locationData.street,
          'location.number': holidayData.locationData.numberBox,
          'location.locality': holidayData.locationData.locality,
          'location.postalCode': holidayData.locationData.postalCode,
          'location.country': holidayData.locationData.country,
          'creatorId': holidayData.creatorId,
        };
        final formData = FormData.fromMap(formDataMap);

        // Ajouter le fichier seulement s'il n'est pas null (comme en web)
        if (holidayData.file != null) {
          formData.files.add(MapEntry(
              'uploadedHolidayPicture',
              await MultipartFile.fromFile(holidayData.file!.path),
          ));
    }

        Response response = await _dio.post('v1/holiday/', data : formData);
        print(response);
      } on DioException catch (e){
        throw ApiException(e.response?.data, e);

      } catch (e, stacktrace) {
        throw ApiException("Une erreur s'est produite lors de la création de votre vacance", stacktrace);
      }
  }

    Future<void> editHoliday(HolidayData holidayData) async {
      try {
        final formDataMap = {
          'name': holidayData.name,
          'description': holidayData.description,
          'startDate': holidayData.startDate.toIso8601String(),
          'endDate': holidayData.endDate.toIso8601String(),
          'location.id' : holidayData.locationData.locationId,
          'location.street': holidayData.locationData.street,
          'location.number': holidayData.locationData.numberBox,
          'location.locality': holidayData.locationData.locality,
          'location.postalCode': holidayData.locationData.postalCode,
          'location.country': holidayData.locationData.country,
          'creatorId': holidayData.creatorId,
          'deleteImage' : holidayData.deleteImage,
          'initialPath' : holidayData.initialPath!
        };
        final formData = FormData.fromMap(formDataMap);

        // Ajouter le fichier seulement s'il n'est pas null (comme en web)
        if (holidayData.file != null) {
          formData.files.add(MapEntry(
            'uploadedHolidayPicture',
            await MultipartFile.fromFile(holidayData.file!.path),
          ));
        }


        Response response = await _dio.put('v1/holiday/${holidayData.holidayId!}', data : formData);
        print(response);
      } on DioException catch (e){
        throw ApiException(e.response?.data, e);

      } catch (e, stacktrace) {
        throw ApiException("Une erreur s'est produite lors de la création de votre vacance", stacktrace);
      }
    }
}