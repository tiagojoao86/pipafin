import 'package:flutter/material.dart';
import 'package:frontend/basics_components/default_buttons.dart';
import 'package:frontend/basics_components/text_util.dart';
import 'package:frontend/components/account_category_detail_component.dart';
import 'package:frontend/enumeration/account_type_enum.dart';
import 'package:frontend/model/base_model.dart';
import 'package:frontend/model/account_category/account_category_dto.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountCategoryGrid extends BaseModel {
  String? description;
  AccountTypeEnum? type;

  AccountCategoryGrid(): super.empty();

  AccountCategoryGrid.fromDTO(AccountCategoryDTO dto) : super(dto.id) {
    description = dto.description;
    type = dto.type;
  }

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

  @override
  List<Widget> getInfoList(AppLocalizations? location) {
    var typeString = type != null ? location!.accountCategoryType(type!.name)
        .toUpperCase()
        : '';
    return [
      TextUtil.label(description),
      TextUtil(typeString)
    ];
  }

  @override
  Future<dynamic> getDetailNavigator(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AccountCategoryDetailComponent(id),
      ),
    );
  }

  @override
  Future<dynamic> getNewNavigator(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AccountCategoryDetailComponent('new'),
      ),
    );
  }


}
