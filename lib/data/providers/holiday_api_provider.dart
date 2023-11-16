import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:holiday_mobile/data/exceptions/api_exception.dart';
import 'package:holiday_mobile/data/models/holiday/holiday.dart';
import 'package:holiday_mobile/data/providers/dio/dio_instance.dart';

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
}