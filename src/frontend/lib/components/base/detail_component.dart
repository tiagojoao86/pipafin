import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend/basics_components/default_buttons.dart';
import 'package:frontend/basics_components/default_colors.dart';
import 'package:frontend/basics_components/text_util.dart';
import 'package:frontend/model/model.dart';
import 'package:frontend/provider/base_provider.dart';
import 'package:provider/provider.dart';

AppLocalizations? location;
abstract class DetailComponent<P extends BaseProvider<G, D>, G extends Model, D extends Model> extends StatefulWidget {

  final String? id;

  const DetailComponent(this.id, {super.key});

  @override
  State<StatefulWidget> createState();

}

abstract class DetailComponentState<P extends BaseProvider<G, D>, G extends Model, D extends Model> extends State<DetailComponent<P,G,D>> {

  String getTitle(AppLocalizations? location);
  void setDataToControllers(D dto);
  List<Widget> buildInnerForm(D dto, BuildContext context);
  getDtoBuildFunction();
  void validateAndSave(D dto, P provider, formKey, VoidCallback close);
  Controllers getControllers();

  final _formKey = GlobalKey<FormState>();

  DetailComponentState();

  @override
  Widget build(BuildContext context) {
    location = AppLocalizations.of(context);
    String? id = widget.id;

    P provider = Provider.of<P>(context, listen: false);

    if (id == 'new') {
      return _buildScaffold(getDtoBuildFunction(), provider);
    }

    return _buildBody(id!, provider);
  }

  FutureBuilder _buildBody(String id, P provider) {
    return FutureBuilder(
      future: provider.findById(id),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return _buildScaffold(snapshot.data!, provider);
        }
      },
    );
  }

  Scaffold _buildScaffold(D dto, P provider) {
    getControllers().clear();
    setDataToControllers(dto);
    return Scaffold(
        appBar: AppBar(
          title: TextUtil.subTitle(getTitle(location), foreground: DefaultColors.black1),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...buildInnerForm(dto, context),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  DefaultButtons.formSaveButton(() => validateAndSave(dto, provider, _formKey, _close), location!.save),
                  DefaultButtons.formCancelButton(() => _close(), location!.cancel),
                ],
              )
            ]
          )
        )
    );
  }

  void _close() {
    Navigator.of(context).pop();
  }

  String? emptyValidator(value) {
    var isString = value is String;

    if (value == null || (isString && value.isEmpty)) {
      return location!.errorCannotBeEmpty;
    }
    return null;
  }
}

abstract class Controllers {
  const Controllers();
  void clear();
}