import 'package:holiday_mobile/main.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
class DateService {

  ///
  /// Vérifie si la date courante est supérieure à celle fournie en paramètre
  ///
  static bool isStartDateValid(DateTime startDate, bool includeTime) {
    tz.TZDateTime now = tz.TZDateTime.now(globalLocation!);
    // Pour ne pas prendre en compte les heures
    if (!includeTime) {
      now = tz.TZDateTime(globalLocation!, now.year, now.month, now.day);
      startDate = DateTime(startDate.year, startDate.month, startDate.day);
    }
    return !startDate.isBefore(now);

  }

  ///
  /// Vérifie si la date de fin est supérieure à celle de début en prenant en compte ou non les heures, minutes, secondes
  ///
  static bool isEndDateValid(DateTime startDate, DateTime endDate, bool includeTime) {
    if (!includeTime) {
      startDate = DateTime(startDate.year, startDate.month, startDate.day);
      endDate = DateTime(endDate.year, endDate.month, endDate.day);
    } else {
      startDate = DateTime(startDate.year, startDate.month, startDate.day, startDate.hour, startDate.minute);
      endDate = DateTime(endDate.year, endDate.month, endDate.day, endDate.hour, endDate.minute);
    }
    return endDate.isAfter(startDate);
  }

  /// Convertit un objet DateTime standard en un objet tz.TZDateTime qui intègre les informations de fuseau horaire.
  /// La méthode permet de choisir si l'heure doit être incluse dans la conversion ou non.
  /// @DateTime dateTime: L'objet DateTime à convertir.
  /// tz.Location location: L'objet tz.Location représentant le fuseau horaire dans lequel convertir dateTime.
  /// {bool considerTime = false} (optionnel): Un booléen indiquant si l'heure doit être prise en compte dans la conversion.
  /// Par défaut, il est défini sur false.
  static tz.TZDateTime convertDateTimeToTzDateTime(DateTime dateTime, tz.Location location, {bool considerTime = false}) {
    if (considerTime) {
      return tz.TZDateTime(location, dateTime.year, dateTime.month, dateTime.day, dateTime.hour, dateTime.minute);
    }
    return tz.TZDateTime(location, dateTime.year, dateTime.month, dateTime.day);
  }

  ///
  /// Convertir un objet TzDateTime en DateTime en prenant en compte ou non les heures, minutes, secondes.
  ///
  static DateTime convertTzDateTimeToDateTime(tz.TZDateTime tzDateTime, {bool considerTime = false}) {
    if(considerTime) {
      return DateTime(tzDateTime.year, tzDateTime.month, tzDateTime.day, tzDateTime.hour, tzDateTime.minute);
    }
    return DateTime(tzDateTime.year, tzDateTime.month, tzDateTime.day);
  }



}