import 'package:flutter/material.dart';
import 'package:frontend/basics_components/text_util.dart';
import 'package:frontend/components/account_category/account_category_detail_component.dart';
import 'package:frontend/components/base/list_component.dart';
import 'package:frontend/enumeration/logic_operators_enum.dart';
import 'package:frontend/l10n/l10n_service.dart';
import 'package:frontend/model/account_category/account_category_dto.dart';
import 'package:frontend/model/account_category/account_category_filter_dto.dart';
import 'package:frontend/model/account_category/account_category_grid.dart';
import 'package:frontend/model/data/pageable_data_request.dart';
import 'package:frontend/state/account_category_store_state.dart';

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
  _AccountCategoryListComponentState() : super(AccountCategoryStoreState(), PageableDataRequest.basic(AccountCategoryFilterDTO(LogicOperatorsEnum.and)));

  @override
  List<Widget> buildInfoList(AccountCategoryGrid? item) {
    if (item == null) return [];

    var type = item.type != null
        ? L10nService.l10n().accountCategoryType(item.type!.name).toUpperCase()
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
    return L10nService.l10n().accountCategoryTitle;
  }
}
