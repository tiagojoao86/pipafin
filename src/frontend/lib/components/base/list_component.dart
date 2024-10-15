import 'package:flutter/material.dart';
import 'package:frontend/basics_components/show_modal_bottom_sheet_component.dart';
import 'package:frontend/basics_components/app_bar_register_component.dart';
import 'package:frontend/basics_components/card_grid_component.dart';
import 'package:frontend/basics_components/default_buttons.dart';
import 'package:frontend/basics_components/default_colors.dart';
import 'package:frontend/basics_components/default_sizes.dart';
import 'package:frontend/basics_components/dropdown_component.dart';
import 'package:frontend/basics_components/pagination_bar.dart';
import 'package:frontend/basics_components/sort_selection_component.dart';
import 'package:frontend/basics_components/text_form_component.dart';
import 'package:frontend/basics_components/text_util.dart';
import 'package:frontend/components/base/controllers.dart';
import 'package:frontend/enumeration/logic_operators_enum.dart';
import 'package:frontend/l10n/l10n_service.dart';
import 'package:frontend/model/base_grid_dto.dart';
import 'package:frontend/model/data/filter_dto.dart';
import 'package:frontend/model/data/sort.dart';
import 'package:frontend/model/data/pageable_data_request.dart';
import 'package:frontend/model/base_dto.dart';
import 'package:frontend/state/base_state.dart';
import 'package:frontend/state/base_store_state.dart';

abstract class ListComponent<G extends BaseGridDTO, D extends BaseDTO, F extends FilterDTO>
    extends StatefulWidget {
  const ListComponent({super.key});

  @override
  State<StatefulWidget> createState();
}

abstract class ListComponentState<G extends BaseGridDTO, D extends BaseDTO, F extends FilterDTO>
    extends State<ListComponent<G, D, F>> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Widget buildDetailComponent({String? id});
  String getTitleComponent(BuildContext context);
  List<Widget> buildInfoList(G? item);
  List<Widget> buildFilterComponents();
  Controllers getListFilterControllers();
  F getFilterData(PageableDataRequest<F> pageableDataRequest);
  F getClearFilter();
  List<DropdownMenuItem<Property>> getPropertiesToSort();
  BaseStoreState<G, D, F> store;
  PageableDataRequest<F> pageableDataRequest;
  final formFilterListKey = GlobalKey<FormState>();
  List<Sort> sortList = [];

  ListComponentState(this.store, this.pageableDataRequest);

  _changePage(int pageNumber, int pageSize) {
    pageableDataRequest.pageNumber = pageNumber;
    pageableDataRequest.pageSize = pageSize;
    return store.changePage(pageableDataRequest);
  }

  _doFilter() {
    pageableDataRequest.pageNumber = 0;
    pageableDataRequest.filter = getFilterData(pageableDataRequest);
    store.list(pageableDataRequest);
  }

  _clearFilters() {
    pageableDataRequest.pageNumber = 0;
    pageableDataRequest.filter = getClearFilter();
    store.list(pageableDataRequest);
  }

  _doSort() {
    pageableDataRequest.pageNumber = 0;
    store.list(pageableDataRequest);
  }

  _clearSort() {
    pageableDataRequest.pageNumber = 0;
    pageableDataRequest.sort = [];
    store.list(pageableDataRequest);
  }

  _addFieldToSort(value) {
    if (!pageableDataRequest.sort.contains(value)) {
      pageableDataRequest.sort.add(value);
    }
  }

  _removeFieldToSort(value) {
    if (pageableDataRequest.sort.contains(value)) {
      pageableDataRequest.sort.remove(value);
    }
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
          () => showSortModal(),
          getTitleComponent(context),
          context
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
          return PaginationBar(changePage: _changePage, totalRegisters: store.totalRegisters);
        }
    );
  }

  showSortModal() {
    sortList = pageableDataRequest.sort;
    var title = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextUtil.subTitle(L10nService.l10n().sort),
        ]
    );

    List<DropdownMenuItem<Property>> items = getPropertiesToSort();
    var body = SortSelectionComponent(
      propertiesList: items,
      onAddSortItem: _addFieldToSort,
      onRemoveSortItem: _removeFieldToSort,
      initialValues: pageableDataRequest.sort,
    );

    var bottom = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        DefaultButtons.formButton(
                () {
              _clearSort();
              Navigator.pop(context);
            },
            L10nService.l10n().clear,
            Icons.clear),
        DefaultButtons.formCancelButton(
                () => Navigator.pop(context),
            L10nService.l10n().cancel),
        DefaultButtons.formButton(
                () {
              _doSort();
              Navigator.pop(context);
            },
            L10nService.l10n().toSort,
            Icons.sort),
      ],
    );

    ShowModalBottomSheetComponent.getModal(context, title, body, bottom);
  }

  List<Widget> getSortList() {
    List<Widget> components = [];

    for (var value in sortList) {
      components.add(Row(
        children: [
          TextUtil('${value.property.label} (${value.direction.name})'),
          DefaultButtons.transparentButton(() => _removeFieldToSort(value), const Icon(Icons.close))
        ],
      ));
    }

    return components;
  }

  showFilterModal() {
    var title = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextUtil.subTitle(L10nService.l10n().filter),
        DropdownComponent(
          pageableDataRequest.filter.operator,
          TextFormComponent.emptyValidator,
          LogicOperatorsEnum.getDropdownList(),
              (value) {
            pageableDataRequest.filter.operator = value!;
          },
          L10nService.l10n().logicOperator,
          width: 100,
          height: 50,
        ),
      ],
    );

    var body = Form(
      key: formFilterListKey,
      child: ListView(
        children: [
          ...buildFilterComponents(),
        ],
      ),
    );

    var bottom = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        DefaultButtons.formButton(
                () {
              _clearFilters();
              Navigator.pop(context);
            },
            L10nService.l10n().clear,
            Icons.clear),
        DefaultButtons.formCancelButton(
                () => Navigator.pop(context),
            L10nService.l10n().cancel),
        DefaultButtons.formButton(
                () {
              _doFilter();
              Navigator.pop(context);
            },
            L10nService.l10n().doFilter,
            Icons.search),
      ],
    );
    ShowModalBottomSheetComponent.getModal(context, title, body, bottom);
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
        store.delete(item.getId());
      }, iconColor: DefaultColors.textColor),
    ];
  }
}
