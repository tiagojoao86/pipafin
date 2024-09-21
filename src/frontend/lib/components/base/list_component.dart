import 'package:flutter/material.dart';
import 'package:frontend/basics_components/app_bar_register_component.dart';
import 'package:frontend/basics_components/card_grid_component.dart';
import 'package:frontend/basics_components/default_buttons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend/basics_components/default_colors.dart';
import 'package:frontend/basics_components/text_util.dart';
import 'package:frontend/model/model.dart';
import 'package:frontend/provider/base_provider.dart';
import 'package:provider/provider.dart';

AppLocalizations? location;
abstract class ListComponent<P extends BaseProvider<G, D>, G extends Model, D extends Model> extends StatefulWidget {

  const ListComponent({super.key});

  @override
  State<StatefulWidget> createState();

}

abstract class ListComponentState<P extends BaseProvider<G, D>, G extends Model, D extends Model> extends State<ListComponent<P,G,D>> {

  Widget buildDetailComponent(String id);
  String getTitleComponent(BuildContext context);
  List<Widget> buildInfoList(G? item);

  ListComponentState();

  @override
  void initState() {
    super.initState();
    context.read<P>().fetch();
  }

  @override
  Widget build(BuildContext context) {
    location = AppLocalizations.of(context);
    return _buildBody();
  }

  Widget _buildBody() {
    return Consumer<P>(
      builder: (context, provider, child) {
        return _buildScaffold(provider);
      }
    );
  }

  Scaffold _buildScaffold(P provider) {
    return Scaffold(
      appBar: AppBarRegisterComponent(() =>
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => buildDetailComponent('new'),
          ),
        ),
        getTitleComponent(context)),
      body: provider.list.isEmpty ?
        Center(child: TextUtil.subTitle(location!.noRegistersFound, foreground: DefaultColors.black1))
        : _buildItems(provider)
    );
  }

  Column _buildItems(P provider) {
    return
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: provider.list.length,
              itemBuilder: (BuildContext context, int index) {
                List<Widget> info = buildList(provider.list[index]);
                List<Widget> actions = buildActionsList(provider.list[index], provider);

                return CardGridComponent(info, actions);
              }
            ),
          )
        ]
      );
  }

  List<Widget> buildList(G? item) {
    return buildInfoList(item);
  }

  List<Widget> buildActionsList(G? item, P provider) {
    if (item == null) return [];
    return [
      DefaultButtons.editButton(() {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => buildDetailComponent(item.getId()),
          ),
        );
      }),
      DefaultButtons.deleteButton(() async {
        provider.delete(item.getId());
      }),
    ];
  }
}