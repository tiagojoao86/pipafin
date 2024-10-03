import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend/basics_components/dropdown_component.dart';
import 'package:frontend/basics_components/text_form_component.dart';
import 'package:frontend/components/base/detail_component.dart';
import 'package:frontend/enumeration/account_category_type_enum.dart';
import 'package:frontend/model/account_category/account_category_dto.dart';
import 'package:frontend/model/account_category/account_category_filter_dto.dart';
import 'package:frontend/model/account_category/account_category_grid.dart';
import 'package:frontend/state/account_category_store_state.dart';

class AccountCategoryDetailComponent extends DetailComponent<
    AccountCategoryGrid, AccountCategoryDTO, AccountCategoryFilterDTO, AccountCategoryStoreState> {
  const AccountCategoryDetailComponent({super.id, super.key});

  @override
  State<StatefulWidget> createState() {
    return _AccountCategoryDetailComponentState();
  }
}

class _AccountCategoryDetailComponentState extends DetailComponentState<
    AccountCategoryGrid, AccountCategoryDTO, AccountCategoryFilterDTO, AccountCategoryStoreState> {
  _AccountCategoryDetailComponentState()
      : super(AccountCategoryDTO(), AccountCategoryStoreState());

  @override
  AccountCategoryDetailsControllers getControllers() {
    return AccountCategoryDetailsControllers.getInstance();
  }

  @override
  List<Widget> buildInnerForm(AccountCategoryDTO dto, BuildContext context) {
    return [
      TextFormComponent(
          location!.description, getControllers().descriptionController,
          validator: emptyValidator),
      DropdownComponent(
          dto.type,
          emptyValidator,
          AccountCategoryTypeEnum.getDropdownList(context),
          (value) => dto.type = value,
          location!.type),
    ];
  }

  @override
  String getTitle(AppLocalizations? location) {
    return location!.accountCategoryTitle;
  }

  @override
  void setDataToControllers() {
    if (dto.description != null) {
      getControllers().descriptionController.text = dto.description!;
    }
  }

  @override
  Future<void> validateAndSave(Function close) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    dto.description = getControllers().descriptionController.text;
    close(await store.save(dto));
  }
}

class AccountCategoryDetailsControllers extends Controllers {
  static AccountCategoryDetailsControllers? _instance;

  static getInstance() {
    _instance ??= AccountCategoryDetailsControllers();
    return _instance;
  }

  @override
  void clear() {
    descriptionController.clear();
  }

  final descriptionController = TextEditingController();
}
