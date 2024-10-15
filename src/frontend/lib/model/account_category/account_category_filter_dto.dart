import 'dart:convert';

import 'package:frontend/enumeration/account_category_type_enum.dart';
import 'package:frontend/model/data/filter_dto.dart';

class AccountCategoryFilterDTO extends FilterDTO {
  String? description;
  List<AccountCategoryTypeEnum>? types;

  AccountCategoryFilterDTO(super.operator, {this.description, this.types});

  @override
  String toJson() {
    return jsonEncode(getAttributesMap());
  }

  @override
  Map<String, dynamic> getAttributesMap() {
    Map<String, dynamic> map = {};
    if (description != null && description!.isNotEmpty) {
      map.putIfAbsent("description", () => description);
    }

    if (types != null && types!.isNotEmpty) {
      List<String> values = types!.map((it) => it.name.toUpperCase()).toList();
      map.putIfAbsent("types", () => values);
    }

    map.putIfAbsent("operator", () => operator.name.toUpperCase());

    return map;
  }
}