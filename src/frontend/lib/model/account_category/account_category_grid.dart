import 'package:frontend/enumeration/account_category_type_enum.dart';
import 'package:frontend/model/account_category/account_category_dto.dart';
import 'package:frontend/model/model.dart';

class AccountCategoryGrid implements Model {
  String? id;
  String? description;
  AccountCategoryTypeEnum? type;

  AccountCategoryGrid();

  AccountCategoryGrid.fromDTO(AccountCategoryDTO dto) {
    id = dto.id;
    description = dto.description;
    type = dto.type;
  }

  @override
  void fillFromJson(Map<String, dynamic> map) {
    id = map["id"] as String;
    description = map["description"] as String;
    type = AccountCategoryTypeEnum.fromString(map["type"] as String);
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
