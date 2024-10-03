import 'dart:convert';

import 'package:frontend/enumeration/account_category_type_enum.dart';
import 'package:frontend/model/filter/filter_dto.dart';

class AccountCategoryFilterDTO extends FilterDTO {
  String? description;
  List<AccountCategoryTypeEnum>? types;

  AccountCategoryFilterDTO(super.operator, {this.description, this.types});

  @override
  void fillFromJson(Map<String, dynamic> map) {
    throw UnsupportedError("Method fillFromJson in AccountCategoryFilterDTO is not implemented");
  }

  @override
  String? getId() {
    throw UnsupportedError("Method getId in AccountCategoryFilterDTO is not implemented");
  }

  @override
  String toJson() {
    Map<String, dynamic> map = {};
    if (description != null && description!.isNotEmpty) {
      map.putIfAbsent("description", () => description);
    }

    if (types != null && types!.isNotEmpty) {
      List<String> values = types!.map((it) => it.name.toUpperCase()).toList();
      map.putIfAbsent("types", () => values);
    }

    map.addAll(super.getAttributesMap());

    return jsonEncode(map);
  }
}