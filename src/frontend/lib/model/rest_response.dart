import 'dart:convert';
import 'package:frontend/model/data/pageable_data_response.dart';
import 'package:frontend/model/model.dart';
import 'package:http/http.dart';

class RestResponse<T> {
  int? statusCode;
  String? errorMessage;
  dynamic body;

  RestResponse();

  RestResponse.fromPageableDataResponse(Response response, {Function? objCreator}) {
    var json = utf8.decode(response.bodyBytes);
    Map<String, dynamic> map = jsonDecode(json);
    statusCode = map['statusCode'];
    errorMessage = map['errorMessage'];
    var jsonBody = map['body'];

    if (statusCode == 200) {
      if (jsonBody != null) {
        var jsonData = jsonBody['data'];
        PageableDataResponse<T> obj = PageableDataResponse(_extractBodyAsList(jsonData, objCreator), jsonBody['totalRegisters']);
        body = obj;
      }
      return;
    }

    throw Exception('Error: $statusCode. Message: $errorMessage');
  }

  RestResponse.fromJson(Response response, {Function? objCreator}) {
    var json = utf8.decode(response.bodyBytes);
    Map<String, dynamic> map = jsonDecode(json);
    statusCode = map['statusCode'];
    errorMessage = map['errorMessage'];
    var jsonBody = map['body'];

    if (statusCode == 200) {
      _extractBody(jsonBody, objCreator);
      return;
    }

    throw Exception('Error: $statusCode. Message: $errorMessage');
  }

  _extractBody(jsonBody, objCreator) {
    if (jsonBody is List) {
      List<T> result = _extractBodyAsList(jsonBody, objCreator);
      body = result;
      return;
    }

    _extractBodyAsOther(jsonBody, objCreator);
  }

  _extractBodyAsList(jsonBody, objCreator) {
    List<T> result = [];
    for (final item in jsonBody) {
      if (objCreator != null) {
        T obj = objCreator();
        if (obj is Model) {
          obj.fillFromJson(item);
          result.add(obj);
          continue;
        }
      }
      result.add(jsonDecode(item));
    }
    return result;
  }

  _extractBodyAsOther(jsonBody, objCreator) {
    if (objCreator != null) {
      T obj = objCreator();
      if (obj is Model) {
        obj.fillFromJson(jsonBody);
        body = obj;
        return;
      }
    }

    if (jsonBody is String) {
      body = jsonBody;
      return;
    }

    body = jsonDecode(jsonBody);
  }
}