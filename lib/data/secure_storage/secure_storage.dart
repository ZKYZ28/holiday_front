import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:holiday_mobile/data/exceptions/holiday_storage_exception.dart';

class SecureStorage {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  static const jwtKey = 'SL_TOKEN';

  /// Permet d'écrire des données dans le stockage sécurisé du téléphone (chiffré)
  /// [HolidayStorageException] si l'utilisateur essaie de tester l'application à partir
  /// d'une plateforme qui ne prend pas en charge le secure storage
  Future<void> writeSecureData(String key, String value) async {
    try {
      await storage.write(key: key, value: value);
    } on PlatformException {
      throw HolidayStorageException("Plateforme de stockage non supporté. Merci d'utilisateur un appareil Android");
    }
  }

  /// Déchiffre et renvoie la valeur si la clé existe, sinon null
  /// [HolidayStorageException] si l'utilisateur essaie de tester l'application à partir
  /// d'une plateforme qui ne prend pas en charge le secure storage
   Future<String?> readSecureData(String key) async {
    try {
      return await storage.read(key: key);
    } on PlatformException {
      throw HolidayStorageException("Plateforme de stockage non supporté. Merci d'utilisateur un appareil Android");
    }
  }
  /// Supprimer l'entrée correspondante à la clé dans le Secure Storage si la clé existe. Sinon, ne fait rien
  /// [HolidayStorageException] si l'utilisateur essaie de tester l'application à partir
  /// d'une plateforme qui ne prend pas en charge le secure storage
  Future<void> deleteSecureData(String key) async {
    try {
      return await storage.delete(key: key);
    } on PlatformException {
      throw HolidayStorageException("Plateforme de stockage non supporté. Merci d'utilisateur un appareil Android");
    }
  }




}