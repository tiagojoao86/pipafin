import 'package:flutter/material.dart';
import 'package:frontend/basics_components/app_bar_register_component.dart';
import 'package:frontend/basics_components/card_grid_component.dart';
import 'package:frontend/basics_components/default_buttons.dart';
import 'package:frontend/basics_components/default_colors.dart';
import 'package:frontend/basics_components/default_sizes.dart';
import 'package:frontend/basics_components/pagination_bar.dart';
import 'package:frontend/basics_components/text_util.dart';
import 'package:frontend/l10n/l10n_service.dart';
import 'package:frontend/model/data/filter_dto.dart';
import 'package:frontend/model/data/pageable_data_request.dart';
import 'package:frontend/model/model.dart';
import 'package:frontend/state/base_state.dart';
import 'package:frontend/state/base_store_state.dart';

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
  PageableDataRequest<F> pageableDataRequest;

  ListComponentState(this.store, this.pageableDataRequest);

  changePage(int pageNumber, int pageSize) {
    pageableDataRequest.pageNumber = pageNumber;
    pageableDataRequest.pageSize = pageSize;
    return store.changePage(pageableDataRequest);
  }

  @override
  void initState() {
    super.initState();
    store.list(pageableDataRequest);
  }

  @override
  Widget build(BuildContext context) {
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
      body: Container(
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
        margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        decoration: const BoxDecoration(
          color: DefaultColors.transparency,
          borderRadius: BorderRadius.all(Radius.circular(DefaultSizes.borderRadius)),
        ),
        child: getListComponent(),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: getPaginationBar(),
        color: DefaultColors.transparent,
        height: DefaultSizes.footerHeight,
      )
    );
  }

  getPaginationBar() {
    return ListenableBuilder(
        listenable: store,
        builder: (context, child) {
          return PaginationBar(changePage: changePage, totalRegisters: store.totalRegisters);
        }
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
                        () => Navigator.pop(context), L10nService.l10n().cancel),
                    DefaultButtons.formPrimaryButton(
                        () => Navigator.pop(context),
                        L10nService.l10n().doFilter,
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
                  foreground: DefaultColors.black2),
            );
          } else if (state is ListedBaseState) {
            if (state.list.isEmpty) {
              body = Center(
                  child: TextUtil.subTitle(L10nService.l10n().noRegistersFound,
                      foreground: DefaultColors.black2));
            } else {
              return _buildItems(state);
            }
          }

          return body;
        });
  }

  Column _buildItems(ListedBaseState state) {
    var list = state.list as List<G>;
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Expanded(
        child:
        ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            List<Widget> info = buildList(list[index]);
            List<Widget> actions = buildActionsList(list[index]);

            return CardGridComponent(info, actions);
          }
        ),
      ),
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
      }, iconColor: DefaultColors.textColor),
      DefaultButtons.deleteButton(() async {
        store.delete(item.getId()!);
      }, iconColor: DefaultColors.textColor),
    ];
  }
}
