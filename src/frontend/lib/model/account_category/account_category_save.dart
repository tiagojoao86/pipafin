import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend/enumeration/account_type_enum.dart';
import 'package:frontend/model/base_model.dart';
import 'package:frontend/model/account_category/account_category_dto.dart';

class AccountCategorySave extends BaseModel {
  String? description;
  AccountTypeEnum? type;

  AccountCategorySave.empty(): super.empty();

  AccountCategorySave(super.id, {
    required this.description,
    required this.type
  });

  AccountCategorySave.fromDTO(AccountCategoryDTO dto) : super(dto.id) {
    description = dto.description;
    type = dto.type;
  }

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
