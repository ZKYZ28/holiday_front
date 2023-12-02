class Configuration {
  static const googleInvalidKey = 'INVALID_TOKEN';
  static Configuration? _instance;
  late String baseUrl;
  late String discussionHubUrl;
  final bool isProduction;

  factory Configuration({bool? isProduction}) {
    return _instance ??= Configuration._internal(isProduction: isProduction!);
  }

  Configuration._internal({required this.isProduction}) {
    baseUrl = isProduction ? 'https://porthos-intra.cg.helmo.be/q210054/' : 'https://10.0.2.2:7048/';
    discussionHubUrl = isProduction ? 'https://porthos-intra.cg.helmo.be/q210054/chat' : 'https://10.0.2.2:7048/chat';
  }

  String get getBaseUrl => baseUrl;
  String get getDiscussionHubUrl => discussionHubUrl;
}