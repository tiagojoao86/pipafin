import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend/basics_components/default_buttons.dart';
import 'package:frontend/basics_components/default_colors.dart';
import 'package:frontend/basics_components/text_util.dart';
import 'package:frontend/enumeration/account_type_enum.dart';
import 'package:frontend/model/account_category/account_category_save.dart';
import 'package:frontend/services/account_category_service.dart';

AppLocalizations? location;
const AccountCategoryService service = AccountCategoryService();

class AccountCategoryDetailComponent extends StatefulWidget {

  final String? id;

  const AccountCategoryDetailComponent(this.id, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _AccountCategoryDetailComponent();
  }

}

class _AccountCategoryDetailComponent extends State<AccountCategoryDetailComponent> {

  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();

  _AccountCategoryDetailComponent();

  @override
  Widget build(BuildContext context) {
    location = AppLocalizations.of(context);
    String? id = widget.id;

    if (id == 'new') {
      return _buildScaffold(AccountCategorySave.empty());
    }

    return _buildBody();
  }

  FutureBuilder _buildBody() {
    return FutureBuilder(
        future: service.list(),
        builder: (context, snapshot) {
          return snapshot.hasData ?
          _buildScaffold(snapshot.data) :
          const Center(
            child: CircularProgressIndicator(),
          );
        }
    );
  }

  Scaffold _buildScaffold(AccountCategorySave dto) {
    return Scaffold(
        appBar: AppBar(
          title: TextUtil.subTitle(location!.accountCategoryTitle, foreground: DefaultColors.black1),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: TextFormField(
                    controller: _descriptionController,
                    validator: _emptyValidator,
                    decoration: InputDecoration(
                      labelText: location!.description,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButtonFormField(
                      validator: _emptyValidator,
                      items: AccountTypeEnum.getDropdownList(context),
                      onChanged: (value) => dto.type = value,
                      decoration: InputDecoration(
                        labelText: location!.type,
                        border: const OutlineInputBorder(),
                      ),
                    )
                  ),
                ),
                Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    DefaultButtons.formSaveButton(() => _validateAndSave(dto, context), location!.save),
                    DefaultButtons.formCancelButton(() => _close(context), location!.cancel),
                  ],
                )
              ],
            ),
          ),
        )
    );
  }

  Future<void> _validateAndSave(AccountCategorySave dto, BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    dto.description = _descriptionController.text;
    await service.save(dto);
    if (context.mounted) _close(context);
  }

  String? _emptyValidator(value) {
    var isString = value is String;

    if (value == null || (isString && value.isEmpty)) {
      return location!.errorCannotBeEmpty;
    }
    return null;
  }

  void _close(BuildContext context) {
    Navigator.of(context).pop();
  }

}