import 'dart:convert';

import 'package:frontend/enumeration/person_type_enum.dart';
import 'package:frontend/model/data/filter_dto.dart';

class PersonFilterDTO extends FilterDTO {

  String? name;
  List<PersonTypeEnum>? types;
  String? document;
  String? phone;
  String? address;

  PersonFilterDTO(super.operator, {this.name, this.types, this.document, this.phone, this.address});

  @override
  void fillFromJson(Map<String, dynamic> map) {
    throw UnsupportedError("Method fillFromJson in PersonFilterDTO is not implemented");
  }

  @override
  String? getId() {
    throw UnsupportedError("Method getId in PersonFilterDTO is not implemented");
  }

  @override
  String toJson() {
    return jsonEncode(getAttributesMap());
  }

  @override
  Map<String, dynamic> getAttributesMap() {
    Map<String, dynamic> map = {};
    if (name != null && name!.isNotEmpty) {
      map.putIfAbsent("name", () => name);
    }

    if (types != null && types!.isNotEmpty) {
      List<String> values = types!.map((it) => it.name.toUpperCase()).toList();
      map.putIfAbsent("types", () => values);
    }

    if (document != null && document!.isNotEmpty) {
      map.putIfAbsent("document", () => document);
    }

    if (phone != null && phone!.isNotEmpty) {
      map.putIfAbsent("phone", () => phone);
    }

    if (address != null && address!.isNotEmpty) {
      map.putIfAbsent("address", () => address);
    }

    map.putIfAbsent("operator", () => operator.name.toUpperCase());

    return map;
  }
}