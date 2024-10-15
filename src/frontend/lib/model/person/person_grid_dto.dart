import 'package:frontend/enumeration/person_type_enum.dart';
import 'package:frontend/model/base_grid_dto.dart';
import 'package:frontend/model/person/person_dto.dart';

class PersonGridDTO implements BaseGridDTO {
  String? id;
  String? tradeName;
  String? name;
  PersonTypeEnum? personType;

  PersonGridDTO();

  PersonGridDTO.fromDTO(PersonDTO dto) {
    id = dto.id;
    tradeName = dto.tradeName;
    personType = dto.personType;
    name = dto.name;
  }

  @override
  void fillFromJson(Map<String, dynamic> map) {
    id = map["id"] as String;
    if (map["tradeName"] != null) {
      tradeName = map["tradeName"] as String;
    }
    name = map["name"] as String;
    personType = PersonTypeEnum.fromString(map["personType"] as String);
  }

  @override
  String getId() {
    return id!;
  }
}
