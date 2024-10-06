import 'package:flutter/material.dart';
import 'package:frontend/basics_components/default_buttons.dart';
import 'package:frontend/basics_components/default_colors.dart';
import 'package:frontend/basics_components/text_util.dart';
import 'package:frontend/l10n/l10n_service.dart';
import 'package:frontend/model/data/filter_dto.dart';
import 'package:frontend/model/model.dart';
import 'package:frontend/state/base_state.dart';
import 'package:frontend/state/base_store_state.dart';

abstract class DetailComponent<G extends Model, D extends Model, F extends FilterDTO,
    S extends BaseStoreState<G, D, F>> extends StatefulWidget {
  final String? id;
  const DetailComponent({this.id, super.key});

  @override
  State<StatefulWidget> createState();
}

abstract class DetailComponentState<G extends Model, D extends Model, F extends FilterDTO,
    S extends BaseStoreState<G, D, F>> extends State<DetailComponent<G, D, F, S>> {
  String getTitle();
  void setDataToControllers();
  List<Widget> buildInnerForm(D dto, BuildContext context);
  void validateAndSave(Function close);
  Controllers getControllers();

  S store;
  D dto;

  final formKey = GlobalKey<FormState>();

  DetailComponentState(this.dto, this.store);

  @override
  Widget build(BuildContext context) {
    store.findById(widget.id);

    return _buildListenable();
  }

  Scaffold _buildListenable() {
    getControllers().clear();
    return _buildScaffold();
  }

  Scaffold _buildScaffold() {
    return Scaffold(
        appBar: AppBar(
          title: TextUtil.subTitle(getTitle(),
              foreground: DefaultColors.black1),
        ),
        body: ListenableBuilder(
            listenable: store,
            builder: (context, child) {
              var state = store.state;
              if (state is FoundedBaseState) {
                dto = state.dto as D;
                setDataToControllers();
                return _buildForm();
              } else if (state is NewRegisterBaseState) {
                return _buildForm();
              } else if (state is ErrorBaseState) {
                return Center(
                  child: TextUtil.subTitle(state.message,
                      foreground: DefaultColors.black1),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }

  Form _buildForm() {
    return Form(
        key: formKey,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          ...buildInnerForm(dto, context),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              DefaultButtons.formSaveButton(
                  () => validateAndSave(_close), L10nService.l10n().save),
              DefaultButtons.formCancelButton(
                  () => _close(null), L10nService.l10n().cancel),
            ],
          )
        ]));
  }

  void _close(G? item) {
    Navigator.of(context).pop(item);
  }

  String? emptyValidator(value) {
    var isString = value is String;

    if (value == null || (isString && value.isEmpty)) {
      return L10nService.l10n().errorCannotBeEmpty;
    }
    return null;
  }
}

abstract class Controllers {
  const Controllers();
  void clear();
}
