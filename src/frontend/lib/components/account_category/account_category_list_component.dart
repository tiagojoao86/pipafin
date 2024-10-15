import 'package:flutter/material.dart';
import 'package:frontend/basics_components/multi_select_component.dart';
import 'package:frontend/basics_components/text_form_component.dart';
import 'package:frontend/basics_components/text_util.dart';
import 'package:frontend/components/account_category/account_category_detail_component.dart';
import 'package:frontend/components/base/controllers.dart';
import 'package:frontend/components/base/list_component.dart';
import 'package:frontend/enumeration/account_category_type_enum.dart';
import 'package:frontend/enumeration/logic_operators_enum.dart';
import 'package:frontend/l10n/l10n_service.dart';
import 'package:frontend/model/account_category/account_category_dto.dart';
import 'package:frontend/model/account_category/account_category_filter_dto.dart';
import 'package:frontend/model/account_category/account_category_grid.dart';
import 'package:frontend/model/data/sort.dart';
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
  AccountCategoryFilterDTO getFilterData(PageableDataRequest<AccountCategoryFilterDTO> pageableDataRequest) {
    var filter = pageableDataRequest.filter;
    filter.description = getListFilterControllers().descriptionController.text;
    filter.types = pageableDataRequest.filter.types;
    return filter;
  }

  @override
  AccountCategoryFilterDTO getClearFilter() {
    getListFilterControllers().clear();
    return AccountCategoryFilterDTO(LogicOperatorsEnum.and);
  }

  @override
  List<Widget> buildFilterComponents() {
    pageableDataRequest.filter.types ??= [];
    return [
      TextFormComponent(L10nService.l10n().name, getListFilterControllers().descriptionController),
      MultiSelectComponent<AccountCategoryTypeEnum>(L10nService.l10n().type, AccountCategoryTypeEnum.getDropdownList(),
              (value) => _addAccountCategoryTypeToFilter(value), (value) => _removeAccountCategoryTypeToFilter(value),
          pageableDataRequest.filter.types!
      ),
    ];
  }

  _addAccountCategoryTypeToFilter(value) {
    if (!pageableDataRequest.filter.types!.contains(value)) {
      pageableDataRequest.filter.types!.add(value);
    }
  }

  _removeAccountCategoryTypeToFilter(value) {
    if (pageableDataRequest.filter.types!.contains(value)) {
      pageableDataRequest.filter.types!.remove(value);
    }
  }

  @override
  Widget buildDetailComponent({String? id}) {
    return AccountCategoryDetailComponent(id: id);
  }

  @override
  String getTitleComponent(BuildContext context) {
    return L10nService.l10n().accountCategoryTitle;
  }

  @override
  AccountCategoryListFilterControllers getListFilterControllers() {
    return AccountCategoryListFilterControllers.getInstance();
  }

  @override
  List<DropdownMenuItem<Property>> getPropertiesToSort() {
    return [
      DropdownMenuItem(value: Property(L10nService.l10n().description, 'description'), child: Text(L10nService.l10n().description),),
      DropdownMenuItem(value: Property(L10nService.l10n().type, 'type'), child: Text(L10nService.l10n().type),)
    ];
  }
}

class AccountCategoryListFilterControllers extends Controllers {

  static AccountCategoryListFilterControllers? _instance;

  static getInstance() {
    _instance ??= AccountCategoryListFilterControllers();
    return _instance;
  }

  @override
  void clear() {
    descriptionController.clear();
    typeAccountCategoryController.clear();
  }

  final descriptionController = TextEditingController();
  final typeAccountCategoryController = TextEditingController();

}
