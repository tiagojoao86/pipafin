import 'package:flutter/material.dart';
import 'package:frontend/components/account_category_detail_component.dart';
import 'package:frontend/basics_components/app_bar_register_component.dart';
import 'package:frontend/basics_components/card_grid_component.dart';
import 'package:frontend/basics_components/default_buttons.dart';
import 'package:frontend/basics_components/text_util.dart';
import 'package:frontend/model/account_category/account_category_grid.dart';
import 'package:frontend/services/account_category_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

AppLocalizations? location;
const AccountCategoryService service = AccountCategoryService();

class AccountCategoryListComponent extends StatelessWidget {

  const AccountCategoryListComponent({super.key});

  @override
  Widget build(BuildContext context) {
    location = AppLocalizations.of(context);
    return _buildBody(context);
  }

  FutureBuilder _buildBody(BuildContext context) {
    return FutureBuilder(
      future: service.list(),
      builder: (context, snapshot) {
        return snapshot.hasData ?
        _buildScaffold(snapshot.data, context) :
        const Center(
          child: CircularProgressIndicator(),
        );
      }
    );
  }

  Scaffold _buildScaffold(List<AccountCategoryGrid>? list, BuildContext context) {
    return Scaffold(
      appBar: AppBarRegisterComponent(() =>
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AccountCategoryDetailComponent('new'),
            ),
          ),
          location!.accountCategoryTitle),
      body: _buildItems(list, context)
    );
  }

  ListView _buildItems(List<AccountCategoryGrid>? list, BuildContext context) {
    return ListView.builder(
        itemCount: list?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          List<Widget> info = buildInfoList(list?[index]);
          List<Widget> actions = buildActionsList(list?[index], context);

          return CardGridComponent(info, actions);
        }
    );
  }

  List<Widget> buildInfoList(AccountCategoryGrid? item) {
    if (item == null) return [];

    var type = item.type != null ?
    location!.accountCategoryType(item.type!.name)
        .toUpperCase()
        : '';
    return [
      TextUtil.label(item.description),
      TextUtil(type)
    ];
  }

  List<Widget> buildActionsList(AccountCategoryGrid? item, BuildContext context) {
    if (item == null) return [];
    return [
      DefaultButtons.editButton(() {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AccountCategoryDetailComponent(item.id!),
          ),
        );
      }),
      DefaultButtons.deleteButton(() async {
        await service.delete(item.id!);
      }),
    ];
  }
}