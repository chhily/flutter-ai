class APIService {
  static const apiKey = "[replace with your key]";
  static const aiModel = "[your ai model]";
  static const baseUrl = "[your base url]";
  APIService._init();
  static APIService? _instance;

  static APIService get instance => _instance ??= APIService._init();
}
