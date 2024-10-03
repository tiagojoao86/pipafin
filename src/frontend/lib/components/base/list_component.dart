import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend/basics_components/app_bar_register_component.dart';
import 'package:frontend/basics_components/card_grid_component.dart';
import 'package:frontend/basics_components/default_buttons.dart';
import 'package:frontend/basics_components/default_colors.dart';
import 'package:frontend/basics_components/text_util.dart';
import 'package:frontend/model/filter/filter_dto.dart';
import 'package:frontend/model/model.dart';
import 'package:frontend/state/base_state.dart';
import 'package:frontend/state/base_store_state.dart';

AppLocalizations? location;

abstract class ListComponent<G extends Model, D extends Model, F extends FilterDTO>
    extends StatefulWidget {
  const ListComponent({super.key});

  @override
  State<StatefulWidget> createState();
}

abstract class ListComponentState<G extends Model, D extends Model, F extends FilterDTO>
    extends State<ListComponent<G, D, F>> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Widget buildDetailComponent({String? id});
  String getTitleComponent(BuildContext context);
  List<Widget> buildInfoList(G? item);
  List<Widget> buildFilterComponents();
  BaseStoreState<G, D, F> store;
  F filter;

  ListComponentState(this.store, this.filter);

  @override
  void initState() {
    super.initState();
    store.list(filter);
  }

  @override
  Widget build(BuildContext context) {
    location = AppLocalizations.of(context);
    return _buildBody();
  }

  Widget _buildBody() {
    return _buildScaffold();
  }

  Scaffold _buildScaffold() {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarRegisterComponent(
          () => Navigator.of(context)
                  .push(
                MaterialPageRoute(
                  builder: (context) => buildDetailComponent(),
                ),
              )
                  .then(
                (value) {
                  if (value != null) {
                    store.updateList(value as G);
                  }
                },
              ),
          () => showFilterModal(),
          getTitleComponent(context)),
      body: getListComponent(),
    );
  }

  showFilterModal() {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return BottomSheet(
          onClosing: () => {},
          builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...buildFilterComponents(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DefaultButtons.formCancelButton(
                        () => Navigator.pop(context), location!.cancel),
                    DefaultButtons.formPrimaryButton(
                        () => Navigator.pop(context),
                        location!.doFilter,
                        Icons.search)
                  ],
                )
              ],
            );
          },
        );
      },
    );
  }

  ListenableBuilder getListComponent() {
    return ListenableBuilder(
        listenable: store,
        builder: (context, child) {
          Widget body = Container();
          final state = store.state;
          if (state is LoadingBaseState) {
            body = const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ErrorBaseState) {
            body = Center(
              child: TextUtil.subTitle(state.message,
                  foreground: DefaultColors.black1),
            );
          } else if (state is ListedBaseState) {
            if (state.list.isEmpty) {
              body = Center(
                  child: TextUtil.subTitle(location!.noRegistersFound,
                      foreground: DefaultColors.black1));
            } else {
              return _buildItems(state.list as List<G>);
            }
          }

          return body;
        });
  }

  Column _buildItems(List<G> list) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Expanded(
        child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              List<Widget> info = buildList(list[index]);
              List<Widget> actions = buildActionsList(list[index]);

              return CardGridComponent(info, actions);
            }),
      )
    ]);
  }

  List<Widget> buildList(G? item) {
    return buildInfoList(item);
  }

  List<Widget> buildActionsList(G? item) {
    if (item == null) return [];
    return [
      DefaultButtons.editButton(() {
        Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (context) => buildDetailComponent(id: item.getId()),
          ),
        )
            .then((value) {
          if (value != null) {
            store.updateList(value as G);
          }
        });
      }),
      DefaultButtons.deleteButton(() async {
        store.delete(item.getId()!);
      }),
    ];
  }
}
