import 'dart:io';

import 'package:timezone/timezone.dart';

enum CustomStatus { init, valid, invalid }

class DateTimeWithStatus {
  final TZDateTime? dateTime;
  final CustomStatus customStatus;

  DateTimeWithStatus({this.dateTime, this.customStatus = CustomStatus.init});
}

class FileWithStatus {
  final File? file;
  final bool deleteImage; // seulement pour l'édition comme en web
  final CustomStatus customStatus;

  FileWithStatus({this.file, this.customStatus = CustomStatus.init, this.deleteImage = false});

}

class NoFile {}