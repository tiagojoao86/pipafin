import 'dart:js_interop';

import 'package:frontend/enumeration/account_type_enum.dart';
import 'package:frontend/json/json_converter_adapter.dart';

class AccountCategoryGrid implements JsonConverterAdapter<AccountCategoryGrid>{
  String? id;
  String? description;
  AccountTypeEnum? type;

  AccountCategoryGrid();

  @override
  AccountCategoryGrid fromJson(Map<String, dynamic> map) {
    id = map["id"] as String;
    description = map["description"] as String;
    type = AccountTypeEnum.fromString(map["type"] as String);
    return this;
  }

  @override
  String toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
