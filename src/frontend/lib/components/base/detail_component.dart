import 'package:flutter/material.dart';
import 'package:frontend/basics_components/default_buttons.dart';
import 'package:frontend/basics_components/default_colors.dart';
import 'package:frontend/basics_components/default_sizes.dart';
import 'package:frontend/basics_components/text_util.dart';
import 'package:frontend/components/base/controllers.dart';
import 'package:frontend/l10n/l10n_service.dart';
import 'package:frontend/model/base_grid_dto.dart';
import 'package:frontend/model/data/filter_dto.dart';
import 'package:frontend/model/base_dto.dart';
import 'package:frontend/state/base_state.dart';
import 'package:frontend/state/base_store_state.dart';

abstract class DetailComponent<G extends BaseGridDTO, D extends BaseDTO, F extends FilterDTO,
    S extends BaseStoreState<G, D, F>> extends StatefulWidget {
  final String? id;
  const DetailComponent({this.id, super.key});

  @override
  State<StatefulWidget> createState();
}

abstract class DetailComponentState<G extends BaseGridDTO, D extends BaseDTO, F extends FilterDTO,
    S extends BaseStoreState<G, D, F>> extends State<DetailComponent<G, D, F, S>> {
  String getTitle();
  void setDataToControllers();
  List<Widget> buildInnerForm(BuildContext context);
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
          leading: DefaultButtons.transparentButton(
                  () => Navigator.pop(context), const Icon(Icons.arrow_back)
          ),
          title: TextUtil.subTitle(getTitle(),
              foreground: DefaultColors.textColor),
          backgroundColor: DefaultColors.transparency,
          toolbarHeight: DefaultSizes.headerHeight,
          shape: OutlineInputBorder(
              borderSide: const BorderSide(color: DefaultColors.transparent, width: 0,),
              borderRadius: BorderRadius.circular(DefaultSizes.borderRadius)
          ),
          iconTheme: const IconThemeData(color: DefaultColors.textColor, size:
          DefaultSizes.smallIcon),
        ),
        body:
          Container(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            decoration: const BoxDecoration(
              color: DefaultColors.transparency,
              borderRadius: BorderRadius.all(Radius.circular(DefaultSizes.borderRadius)),
            ),
            child:
              ListenableBuilder(
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
                            foreground: DefaultColors.black2),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
              ),
          ),
        bottomNavigationBar: BottomAppBar(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          color: DefaultColors.transparent,
          height: DefaultSizes.footerHeight,
          child: getDefaultButtons(),
        )
    );
  }

  Widget getDefaultButtons() {
    return
      Container(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        decoration: const BoxDecoration(
        color: DefaultColors.transparency,
        borderRadius: BorderRadius.all(Radius.circular(DefaultSizes.borderRadius)),
        ),
        child:
          Row(
            textDirection: TextDirection.rtl,
            children: [
              DefaultButtons.formSaveButton(
                      () => validateAndSave(_close), L10nService.l10n().save),
              DefaultButtons.formCancelButton(
                      () => _close(null), L10nService.l10n().cancel),
            ],
          ),
      );
  }

  Widget _buildForm() {
    return ListView(children: [
      Form(
        key: formKey,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          ...buildInnerForm(context),

        ]))]);
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