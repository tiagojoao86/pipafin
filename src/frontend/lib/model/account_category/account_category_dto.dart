import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend/enumeration/account_type_enum.dart';
import 'package:frontend/model/base_model.dart';

class AccountCategoryDTO extends BaseModel {
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  AccountTypeEnum? type;
  String? createdBy;
  String? updatedBy;

  AccountCategoryDTO.empty() : super.empty();

  AccountCategoryDTO(super.id, this.description, this.createdAt, this.updatedAt,
      this.type, this.createdBy, this.updatedBy);

  @override
  AccountCategoryDTO fromJson(Map<String, dynamic> map) {
    id = map['id'];
    description = map['description'];
    createdAt = DateTime.parse(map['createdAt']);
    updatedAt = DateTime.parse(map['updatedAt']);
    type = AccountTypeEnum.fromString(map["type"] as String);
    createdBy = map['createdBy'];
    updatedBy = map['updatedBy'];
    return this;
  }

  @override
  String toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }

  @override
  List<Widget> getInfoList(AppLocalizations? location) {
    throw UnimplementedError();
  }

  @override
  Future getDetailNavigator(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> getNewNavigator(BuildContext context) {
    throw UnimplementedError();
  }
  
}