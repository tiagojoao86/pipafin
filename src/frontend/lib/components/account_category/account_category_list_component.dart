import 'package:flutter/material.dart';
import 'package:frontend/components/account_category/account_category_detail_component.dart';
import 'package:frontend/basics_components/text_util.dart';
import 'package:frontend/components/base/list_component.dart';
import 'package:frontend/model/account_category/account_category_dto.dart';
import 'package:frontend/model/account_category/account_category_grid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend/provider/account_category_provider.dart';

AppLocalizations? location;
class AccountCategoryListComponent extends ListComponent<AccountCategoryProvider, AccountCategoryGrid, AccountCategoryDTO> {

  const AccountCategoryListComponent({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AccountCategoryListComponentState();
  }

}

class _AccountCategoryListComponentState extends ListComponentState<AccountCategoryProvider, AccountCategoryGrid, AccountCategoryDTO> {
  @override
  List<Widget> buildInfoList(AccountCategoryGrid? item) {
    if (item == null) return [];

    var type = item.type != null ?
    location!.accountCategoryType(item.type!.name)
        .toUpperCase()
        : '';
    return [
      TextUtil.label(item.description),
      TextUtil(type)
    ];
  }

  @override
  Widget buildDetailComponent(String id) {
    return AccountCategoryDetailComponent(id);
  }

  @override
  String getTitleComponent(BuildContext context) {
    location = AppLocalizations.of(context);
    return location!.accountCategoryTitle;
  }
}