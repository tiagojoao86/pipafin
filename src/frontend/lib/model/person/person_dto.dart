import 'dart:convert';

import 'package:frontend/enumeration/document_type_enum.dart';
import 'package:frontend/enumeration/person_type_enum.dart';
import 'package:frontend/model/model.dart';

class PersonDTO implements Model {
  String? id;
  String? name;
  String? fantasyName;
  PersonTypeEnum? personType;
  String? document;
  DocumentTypeEnum? documentType;
  String? addressNumber;
  String? addressStreet;
  String? addressNeighborhood;
  String? addressCity;
  String? addressState;
  String? addressPostalCode;
  String? phone1;
  String? phone2;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? createdBy;
  String? updatedBy;

  PersonDTO();

  @override
  void fillFromJson(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    fantasyName = map['fantasyName'];
    personType = PersonTypeEnum.fromString(map["personType"] as String);
    document = map['document'];
    documentType = DocumentTypeEnum.fromString(map["documentType"] as String);
    addressNumber = map['addressNumber'];
    addressStreet = map['addressStreet'];
    addressNeighborhood = map['addressNeighborhood'];
    addressCity = map['addressCity'];
    addressState = map['addressState'];
    addressPostalCode = map['addressPostalCode'];
    phone1 = map['phone1'];
    phone2 = map['phone2'];
    createdAt = DateTime.parse(map['createdAt']);
    updatedAt = DateTime.parse(map['updatedAt']);
    createdBy = map['createdBy'];
    updatedBy = map['updatedBy'];
  }

  @override
  String toJson() {
    Map<String, dynamic> map = {};
    map.putIfAbsent("id", () => id);
    map.putIfAbsent("name", () => name);
    map.putIfAbsent("fantasyName", () => fantasyName);
    map.putIfAbsent("personType", () => personType!.name.toUpperCase());
    map.putIfAbsent("document", () => document);
    map.putIfAbsent("documentType", () => documentType!.name.toUpperCase());
    map.putIfAbsent("addressNumber", () => addressNumber);
    map.putIfAbsent("addressStreet", () => addressStreet);
    map.putIfAbsent("addressNeighborhood", () => addressNeighborhood);
    map.putIfAbsent("addressCity", () => addressCity);
    map.putIfAbsent("addressState", () => addressState);
    map.putIfAbsent("addressPostalCode", () => addressPostalCode);
    map.putIfAbsent("phone1", () => phone1);
    map.putIfAbsent("phone2", () => phone2);

    return jsonEncode(map);
  }

  @override
  String getId() {
    return id!;
  }
}