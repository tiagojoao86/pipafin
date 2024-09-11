import 'dart:convert';
import 'package:frontend/json/json_converter_adapter.dart';
import 'package:http/http.dart';

class RResponse<T> {
  int? statusCode;
  String? errorMessage;
  dynamic body;

  RResponse();

  RResponse.fromJson(Response response, {Function? objCreator}) {
    var json = utf8.decode(response.bodyBytes);
    Map<String, dynamic> map = jsonDecode(json);
    statusCode = map['statusCode'];
    errorMessage = map['errorMessage'];
    var jsonBody = map['body'];

    if (statusCode == 200) {
      _extractBody(jsonBody, objCreator);
    }
  }

  _extractBody(jsonBody, objCreator) {
    if (jsonBody is List) {
      _extractBodyAsList(jsonBody, objCreator);
      return;
    }

    _extractBodyAsOther(jsonBody, objCreator);
  }

  _extractBodyAsList(jsonBody, objCreator) {
    List<T> result = [];
    for (final item in jsonBody) {
      if (objCreator != null) {
        var obj = objCreator();
        if (obj is JsonConverterAdapter) {
          result.add(obj.fromJson(item));
          continue;
        }
      }
      result.add(jsonDecode(item));
    }
    body = result;
  }

  _extractBodyAsOther(jsonBody, objCreator) {
    if (objCreator != null) {
      var obj = objCreator();
      if (obj is JsonConverterAdapter) {
        body = obj.fromJson(jsonBody);
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