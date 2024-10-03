import 'package:flutter/material.dart';
import 'package:frontend/components/account_category/account_category_detail_component.dart';
import 'package:frontend/basics_components/text_util.dart';
import 'package:frontend/components/base/list_component.dart';
import 'package:frontend/enumeration/account_category_type_enum.dart';
import 'package:frontend/enumeration/logic_operators_enum.dart';
import 'package:frontend/model/account_category/account_category_dto.dart';
import 'package:frontend/model/account_category/account_category_filter_dto.dart';
import 'package:frontend/model/account_category/account_category_grid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend/state/account_category_store_state.dart';

AppLocalizations? location;

class AccountCategoryListComponent
    extends ListComponent<AccountCategoryGrid, AccountCategoryDTO, AccountCategoryFilterDTO> {
  const AccountCategoryListComponent({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AccountCategoryListComponentState();
  }
}

class _AccountCategoryListComponentState
    extends ListComponentState<AccountCategoryGrid, AccountCategoryDTO, AccountCategoryFilterDTO> {
  _AccountCategoryListComponentState() : super(AccountCategoryStoreState(), AccountCategoryFilterDTO(LogicOperatorsEnum.and));

  @override
  List<Widget> buildInfoList(AccountCategoryGrid? item) {
    if (item == null) return [];

    var type = item.type != null
        ? location!.accountCategoryType(item.type!.name).toUpperCase()
        : '';
    return [TextUtil.label(item.description), TextUtil(type)];
  }

  @override
  List<Widget> buildFilterComponents() {
    return [];
  }

  @override
  Widget buildDetailComponent({String? id}) {
    return AccountCategoryDetailComponent(id: id);
  }

  @override
  String getTitleComponent(BuildContext context) {
    location = AppLocalizations.of(context);
    return location!.accountCategoryTitle;
  }
}
