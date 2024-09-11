class BaseService {
  final String apiUrl = 'localhost:8080';

  const BaseService();

  Uri getUrl(List<String> path) {
    return Uri.http(apiUrl, path.join(""));
  }

}