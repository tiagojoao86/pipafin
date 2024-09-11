import 'dart:convert';

import 'package:frontend/enumeration/account_type_enum.dart';
import 'package:frontend/json/json_converter_adapter.dart';

class AccountCategorySave implements JsonConverterAdapter<AccountCategorySave> {
  String? id;
  String? description;
  AccountTypeEnum? type;

  AccountCategorySave.empty();

  AccountCategorySave({
    this.id,
    required this.description,
    required this.type
  });

  @override
  AccountCategorySave fromJson(Map<String, dynamic> map) {
    id = map["id"] as String;
    description = map["description"] as String;
    type = AccountTypeEnum.fromString(map["type"] as String);
    return this;
  }

  @override
  String toJson() {
    Map<String, dynamic> map = {};
    map.putIfAbsent("id", () => id);
    map.putIfAbsent("description", () => description);
    map.putIfAbsent("type", () => type!.name.toUpperCase());

    return jsonEncode(map);
  }
}
