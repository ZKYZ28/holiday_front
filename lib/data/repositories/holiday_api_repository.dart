import 'package:holiday_mobile/data/models/holiday/holiday.dart';
import 'package:holiday_mobile/data/providers/holiday_api_provider.dart';

class HolidayApiRepository{
  final _holidayProvider = HolidayApiProvider();

  Future<List<Holiday>> fetchHolidayPublished() {
    return _holidayProvider.fetchHolidayPublished();
  }

}