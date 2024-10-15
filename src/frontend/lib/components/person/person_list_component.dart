import 'package:flutter/material.dart';
import 'package:frontend/basics_components/default_colors.dart';
import 'package:frontend/basics_components/multi_select_component.dart';
import 'package:frontend/basics_components/text_form_component.dart';
import 'package:frontend/basics_components/text_util.dart';
import 'package:frontend/components/base/controllers.dart';
import 'package:frontend/components/base/list_component.dart';
import 'package:frontend/components/person/person_detail_component.dart';
import 'package:frontend/enumeration/logic_operators_enum.dart';
import 'package:frontend/enumeration/person_type_enum.dart';
import 'package:frontend/l10n/l10n_service.dart';
import 'package:frontend/model/data/sort.dart';
import 'package:frontend/model/data/pageable_data_request.dart';
import 'package:frontend/model/person/person_dto.dart';
import 'package:frontend/model/person/person_filter_dto.dart';
import 'package:frontend/model/person/person_grid_dto.dart';
import 'package:frontend/state/person_store_state.dart';

class PersonListComponent extends ListComponent<PersonGridDTO, PersonDTO, PersonFilterDTO> {
  const PersonListComponent({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PersonListComponentState();
  }
}

class _PersonListComponentState
    extends ListComponentState<PersonGridDTO, PersonDTO, PersonFilterDTO> {

  _PersonListComponentState() : super(PersonStoreState(), PageableDataRequest.basic(PersonFilterDTO(LogicOperatorsEnum.and)));

  @override
  List<Widget> buildInfoList(PersonGridDTO? item) {
    if (item == null) return [];

    var type = item.personType != null
        ? L10nService.l10n().personType(item.personType!.name).toUpperCase()
        : '';
    return [
      item.personType == PersonTypeEnum.legal
          ? TextUtil(item.tradeName, foreground: DefaultColors.textColor,)
          : TextUtil(item.name, foreground: DefaultColors.textColor,),
      TextUtil(type, foreground: DefaultColors.textColor)
    ];
  }

  @override
  PersonFilterDTO getFilterData(PageableDataRequest<PersonFilterDTO> pageableDataRequest) {
    var filter = pageableDataRequest.filter;
    filter.name = getListFilterControllers().nameController.text;
    filter.document = getListFilterControllers().documentController.text;
    filter.types = pageableDataRequest.filter.types;
    filter.address = getListFilterControllers().addressController.text;
    filter.phone = getListFilterControllers().phoneController.text;
    return filter;
  }

  @override
  PersonFilterDTO getClearFilter() {
    getListFilterControllers().clear();
    return PersonFilterDTO(LogicOperatorsEnum.and);
  }

  @override
  List<Widget> buildFilterComponents() {
    pageableDataRequest.filter.types ??= [];
    return [
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormComponent(L10nService.l10n().name, getListFilterControllers().nameController),
          TextFormComponent(L10nService.l10n().document, getListFilterControllers().documentController),
          MultiSelectComponent<PersonTypeEnum>(L10nService.l10n().type, PersonTypeEnum.getDropdownList(),
                (value) => _addTypePersonToFilter(value), (value) => _removeTypePersonToFilter(value),
                pageableDataRequest.filter.types!
          ),
          TextFormComponent(L10nService.l10n().address, getListFilterControllers().addressController),
          TextFormComponent(L10nService.l10n().phone, getListFilterControllers().phoneController),
        ],
      ),
    ];
  }

  _addTypePersonToFilter(value) {
    if (!pageableDataRequest.filter.types!.contains(value)) {
      pageableDataRequest.filter.types!.add(value);
    }
  }

  _removeTypePersonToFilter(value) {
    if (pageableDataRequest.filter.types!.contains(value)) {
      pageableDataRequest.filter.types!.remove(value);
    }
  }

  @override
  Widget buildDetailComponent({String? id}) {
    return PersonDetailComponent(id: id);
  }

  @override
  String getTitleComponent(BuildContext context) {
    return L10nService.l10n().personTitle;
  }

  @override
  PersonListFilterControllers getListFilterControllers() {
    return PersonListFilterControllers.getInstance();
  }

  @override
  List<DropdownMenuItem<Property>> getPropertiesToSort() {
    return [
      DropdownMenuItem(value: Property(L10nService.l10n().name, 'name'), child: Text(L10nService.l10n().name),),
      DropdownMenuItem(value: Property(L10nService.l10n().tradeName, 'tradeName'), child: Text(L10nService.l10n().tradeName),),
      DropdownMenuItem(value: Property(L10nService.l10n().type, 'personType'), child: Text(L10nService.l10n().type),),
      DropdownMenuItem(value: Property(L10nService.l10n().document, 'document'), child: Text(L10nService.l10n().document),),
      DropdownMenuItem(value: Property(L10nService.l10n().phone1, 'phone1'), child: Text(L10nService.l10n().phone1),),
    ];
  }
}

class PersonListFilterControllers extends Controllers {

  static PersonListFilterControllers? _instance;

  static getInstance() {
    _instance ??= PersonListFilterControllers();
    return _instance;
  }

  @override
  void clear() {
    nameController.clear();
    documentController.clear();
    phoneController.clear();
    addressController.clear();
  }

  final nameController = TextEditingController();
  final documentController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

}


