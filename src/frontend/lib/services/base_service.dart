abstract class BaseService<G, S, D> {
  final String apiUrl = 'localhost:8080';

  const BaseService();

  Uri getUrl(List<String> path, {queryParameters}) {
    return Uri.http(apiUrl, path.join(""), queryParameters);
  }

  Map<String, String> getHeaders() {
    return <String, String>{
      "Content-type":"application/json"
    };
  }

  Future<List<G>> list();

  Future<G> save(S dto);

  Future<String> delete(String uuid);

  Future<D> findById(String id);

}