import 'dart:convert';

import 'package:frontend/model/base_dto.dart';
import 'package:frontend/enumeration/account_category_type_enum.dart';

class AccountCategoryDTO implements BaseDTO {
  String? id;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  AccountCategoryTypeEnum? type;
  String? createdBy;
  String? updatedBy;

  AccountCategoryDTO();

  @override
  void fillFromJson(Map<String, dynamic> map) {
    id = map['id'];
    description = map['description'];
    createdAt = DateTime.parse(map['createdAt']);
    updatedAt = DateTime.parse(map['updatedAt']);
    type = AccountCategoryTypeEnum.fromString(map["type"] as String);
    createdBy = map['createdBy'];
    updatedBy = map['updatedBy'];
  }

  @override
  String toJson() {
    Map<String, dynamic> map = {};
    map.putIfAbsent("id", () => id);
    map.putIfAbsent("description", () => description);
    map.putIfAbsent("type", () => type!.name.toUpperCase());

    return jsonEncode(map);
  }

  @override
  String getId() {
    return id!;
  }
}