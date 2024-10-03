import 'package:frontend/enumeration/person_type_enum.dart';
import 'package:frontend/model/model.dart';
import 'package:frontend/model/person/person_dto.dart';

class PersonGridDTO implements Model {
  String? id;
  String? fantasyName;
  String? name;
  PersonTypeEnum? personType;

  PersonGridDTO();

  PersonGridDTO.fromDTO(PersonDTO dto) {
    id = dto.id;
    fantasyName = dto.fantasyName;
    personType = dto.personType;
    name = dto.name;
  }

  @override
  void fillFromJson(Map<String, dynamic> map) {
    id = map["id"] as String;
    fantasyName = map["fantasyName"] as String;
    name = map["name"] as String;
    personType = PersonTypeEnum.fromString(map["personType"] as String);
  }

  @override
  String toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }

  @override
  String getId() {
    return id!;
  }
}
