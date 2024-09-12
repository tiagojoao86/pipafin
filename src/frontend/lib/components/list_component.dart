import 'package:flutter/material.dart';
import 'package:frontend/components/account_category_detail_component.dart';
import 'package:frontend/basics_components/app_bar_register_component.dart';
import 'package:frontend/basics_components/card_grid_component.dart';
import 'package:frontend/basics_components/default_buttons.dart';
import 'package:frontend/model/account_category/account_category_grid.dart';
import 'package:frontend/model/base_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend/services/account_category_service.dart';
import 'package:frontend/services/base_service.dart';

AppLocalizations? location;
BaseService? service;

class ListComponent<T extends BaseModel> extends StatefulWidget {

  const ListComponent({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ListComponentState<T>();
  }

}

class _ListComponentState<T extends BaseModel> extends State<ListComponent> {

  List<dynamic>? list;

  _ListComponentState() {
    service = getService(T);
    service!.list().then((result) => setState(() => list = result));
  }

  updateItemOnGrid(T? item, isRemoving) {
    if (item == null) return;
    setState(() {
      list ??= [];
      var findIndex = list?.indexWhere((it) => it.id == item.id);

      if (findIndex != null && findIndex != -1) {
        if (isRemoving) {
          list!.removeAt(findIndex);
          return;
        }

        list![findIndex] = item;
        return;
      }

      list?.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    location = AppLocalizations.of(context);
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    if (list == null) return const Center(child: CircularProgressIndicator());
    return _buildScaffold(context);
  }

  Scaffold _buildScaffold(BuildContext context) {
    return Scaffold(
        appBar: AppBarRegisterComponent(() =>
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => getNewComponent(T),
              ),
            ).then((value) => updateItemOnGrid(value, false)),
            getTitle(T)),
        body: _buildItems(context)
    );
  }

  ListView _buildItems(BuildContext context) {
    return ListView.builder(
        itemCount: list?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          List<Widget> info = buildInfoList(list?[index]);
          List<Widget> actions = buildActionsList(list?[index], context);

          return CardGridComponent(info, actions);
        }
    );
  }

  List<Widget> buildInfoList(T? item) {
    return item == null ? [] : item.getInfoList(location);
  }

  List<Widget> buildActionsList(T? item, BuildContext context) {
    if (item == null) return [];
    return [
      DefaultButtons.editButton(() {
        item.getDetailNavigator(context).then((value) => updateItemOnGrid(item, false));
      }),
      DefaultButtons.deleteButton(() async {
        service!.delete(item.id!).then((value) => updateItemOnGrid(item, true));
      }),
    ];
  }
}

BaseService getService(T) {
  if (T == AccountCategoryGrid) return const AccountCategoryService();

  throw Exception('Service not assign for $T');
}

String getTitle(T) {
  if (T == AccountCategoryGrid) return location!.accountCategoryTitle;

  throw Exception('Title not assign for $T');
}

StatefulWidget getNewComponent(T) {
  if (T == AccountCategoryGrid) return const AccountCategoryDetailComponent('new');

  throw Exception('New Component not assign for $T');
}
