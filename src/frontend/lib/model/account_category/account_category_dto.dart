import 'package:frontend/enumeration/account_type_enum.dart';
import 'package:frontend/json/json_converter_adapter.dart';

class AccountCategoryDTO extends JsonConverterAdapter {
  String? id;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  AccountTypeEnum? type;
  String? createdBy;
  String? updatedBy;

  AccountCategoryDTO.empty();

  AccountCategoryDTO(this.id, this.description, this.createdAt, this.updatedAt,
      this.type, this.createdBy, this.updatedBy);

  @override
  fromJson(Map<String, dynamic> map) {
    id = map['id'];
    description = map['description'];
    createdAt = map['createdAt'];
    updatedAt = map['updatedAt'];
    type = map['type'];
    createdBy = map['createdBy'];
    updatedBy = map['updatedBy'];
  }

  @override
  String toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
  
  
}