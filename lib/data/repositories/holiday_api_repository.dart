import 'package:holiday_mobile/data/models/holiday/holiday.dart';
import 'package:holiday_mobile/data/providers/holiday_api_provider.dart';

class HolidayApiRepository{
  final _holidayProvider = HolidayApiProvider();

  Future<List<Holiday>> fetchHolidayPublished() {
    return _holidayProvider.fetchHolidayPublished();
  }

  Future<List<Holiday>> fetchHolidayByParticipant(String participantId) {
    return _holidayProvider.fetchHolidayByParticipant(participantId);
  }

  Future<Holiday> fetchHoliday(String holidayId) {
    return _holidayProvider.fetchHoliday(holidayId);
  }

  Future<void> publishHoliday(Holiday holiday) {
    return _holidayProvider.publishHoliday(holiday);
  }

  Future<void>  deleteHoliday(Holiday holiday) {
    return _holidayProvider. deleteHoliday(holiday);
  }




}