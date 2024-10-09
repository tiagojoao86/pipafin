import 'dart:ui';

import 'package:frontend/constants/rest_constants.dart';
import 'package:frontend/enumeration/document_type_enum.dart';
import 'package:frontend/model/person/person_dto.dart';
import 'package:frontend/model/person/person_grid_dto.dart';
import 'package:frontend/model/rest_response.dart';
import 'package:frontend/services/base_service.dart';
import 'package:http/http.dart' as http;

class PersonService extends BaseService<PersonGridDTO, PersonDTO> {

  const PersonService();

  Future<bool> verifyDuplicateDocument(String document, DocumentTypeEnum type) async {
    var response = await http.get(
        getUrl([RestConstants.rVerifyDuplicateDocument],
            queryParameters: <String, String>
            {RestConstants.fDocument:document, RestConstants.fDocumentType:type.name.toUpperCase()}),
        headers: getHeaders());
    var responseJson = RestResponse<bool>
        .fromJson(response);

    return responseJson.body as bool;
  }

  @override
  VoidCallback getDtoObjectConstructor() {
    return () => PersonDTO();
  }

  @override
  VoidCallback getGridObjectConstructor() {
    return () => PersonGridDTO();
  }

  @override
  Uri getUrl(List<String> complements, {queryParameters}) {
    complements.insert(0, RestConstants.rPerson);
    return getBaseUrl(complements, queryParameters: queryParameters);
  }
}