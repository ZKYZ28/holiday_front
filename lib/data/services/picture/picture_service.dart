class PictureService {

  static bool isHigherFiveMo(int fileSize) {
    const int maxSize = 5 * 1024 * 1024; // 5 Mo en octets
    return fileSize > maxSize;
  }

  static bool isAllowedType(String extension) {
    const List<String> allowedExtensions = ['jpg', 'jpeg', 'png'];
    return allowedExtensions.contains(extension);
  }
}