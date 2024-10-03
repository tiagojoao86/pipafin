import 'dart:ui';
import 'package:frontend/constants/rest_constants.dart';
import 'package:frontend/model/filter/filter_dto.dart';
import 'package:frontend/model/model.dart';
import 'package:frontend/model/rest_response.dart';
import 'package:http/http.dart' as http;
abstract class BaseService<G extends Model, D extends Model> {
  final String apiUrl = 'localhost:8080';

  const BaseService();

  VoidCallback getGridObjectConstructor();
  VoidCallback getDtoObjectConstructor();

  Uri getUrl(List<String> complements, {queryParameters});

  Uri getBaseUrl(List<String> path, {queryParameters}) {
    return Uri.http(apiUrl, path.join(""), queryParameters);
  }

  Map<String, String> getHeaders() {
    return <String, String>{
      "Content-type":"application/json"
    };
  }

  Future<List<G>> list(FilterDTO filter) async {
    var response = await http.post(getUrl(["/query"]), headers: getHeaders(), body: filter.toJson());
    var responseJson = RestResponse<G>
        .fromJson(response, objCreator: getGridObjectConstructor());

    return responseJson.body as List<G>;
  }

  Future<G> save(D dto) async {
    var response = await http.post(getUrl([]),
        body: dto.toJson(), headers: getHeaders());
    var responseJson = RestResponse<G>.fromJson(response, objCreator: getGridObjectConstructor());

    return responseJson.body as G;
  }

  Future<String> delete(String uuid) async {
    var response = await http.delete(getUrl(['/', uuid]),
        headers: getHeaders());
    var responseJson = RestResponse<String>.fromJson(response);

    return responseJson.body as String;
  }

  Future<D> findById(String id) async {
    var response = await http.get(
      getUrl([RestConstants.rFindById], queryParameters: <String, String>{"id":id}),
      headers: getHeaders());
    var responseJson = RestResponse<D>
        .fromJson(response, objCreator: getDtoObjectConstructor());

    return responseJson.body as D;
  }
}