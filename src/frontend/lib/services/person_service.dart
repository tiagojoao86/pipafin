import 'dart:ui';

import 'package:frontend/constants/rest_constants.dart';
import 'package:frontend/model/person/person_dto.dart';
import 'package:frontend/model/person/person_grid_dto.dart';
import 'package:frontend/services/base_service.dart';

class PersonService extends BaseService<PersonGridDTO, PersonDTO> {

  const PersonService();

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