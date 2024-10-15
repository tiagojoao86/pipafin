import 'package:flutter/material.dart';
import 'package:frontend/basics_components/default_buttons.dart';
import 'package:frontend/basics_components/default_colors.dart';
import 'package:frontend/basics_components/default_sizes.dart';
import 'package:frontend/basics_components/dropdown_component.dart';
import 'package:frontend/basics_components/text_form_component.dart';
import 'package:frontend/basics_components/text_util.dart';
import 'package:frontend/l10n/l10n_service.dart';
import 'package:frontend/model/data/sort.dart';

class SortSelectionComponent extends StatefulWidget {

  final List<DropdownMenuItem<Property>> propertiesList;
  final void Function(dynamic value) onAddSortItem;
  final void Function(dynamic value) onRemoveSortItem;
  final List<Sort> initialValues;

  const SortSelectionComponent({
    super.key,
    required this.propertiesList,
    required this.onAddSortItem,
    required this.onRemoveSortItem,
    required this.initialValues,
  });

  @override
  State<StatefulWidget> createState() {
    return _SortSelectionComponent();
  }

}

class _SortSelectionComponent extends State<SortSelectionComponent> {

  Property? selectedProperty;
  SortDirectionEnum? selectedDirection;
  List<Sort> selectedList = [];

  _onAddSelection(selectedProperty, selectedDirection) {
    setState(() {
      if (selectedProperty != null && selectedDirection != null) {
        var sort = Sort(selectedDirection, selectedProperty);
        if (!selectedList.contains(sort)) {
          selectedList.add(sort);
        }

        widget.onAddSortItem(sort);
      }
    });
  }

  _onRemoveItem(Sort value) {
    setState(() {
      if (selectedList.contains(value)) {
        selectedList.remove(value);
      }

      widget.onRemoveSortItem(value);
    });
  }


  @override
  Widget build(BuildContext context) {
    selectedList = widget.initialValues;
    return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(children: [
            DropdownComponent(selectedProperty, TextFormComponent.emptyValidator, widget.propertiesList, (value) => selectedProperty = value, L10nService.l10n().property),
            DropdownComponent(selectedDirection, TextFormComponent.emptyValidator, SortDirectionEnum.getDropdownList(), (value) => selectedDirection = value, L10nService.l10n().direction),
            Padding(padding: const EdgeInsets.fromLTRB(0, 0, 10, 0), child: DefaultButtons.buttonAdd(() => _onAddSelection(selectedProperty, selectedDirection))),
          ]
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Container(
              padding: selectedList.isNotEmpty ? const EdgeInsets.fromLTRB(5, 5, 5, 5) : EdgeInsets.zero,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                      bottomStart: Radius.circular(DefaultSizes.borderRadius),
                      bottomEnd: Radius.circular(DefaultSizes.borderRadius)
                  ),
                  color: DefaultColors.transparency
              ),
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child:
              GridView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: selectedList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 4,
                ),
                itemBuilder: (context, index) {
                  var label = selectedList.elementAt(index).property.label;
                  var valueLabel = selectedList.elementAt(index).direction ==
                      SortDirectionEnum.asc ? L10nService.l10n().asc : L10nService.l10n().desc;
                  var value  = selectedList.elementAt(index);
                  return
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                        padding: const EdgeInsets.fromLTRB(10, 0, 2, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(DefaultSizes.borderRadius),
                          color: DefaultColors.itemTransparent,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              fit: FlexFit.tight,
                              flex: 9,
                              child: TextUtil('${index+1}. $label ($valueLabel)'),
                            ),
                            Flexible(
                              fit: FlexFit.tight,
                              flex: 3,
                              child: DefaultButtons.transparentButton(() => _onRemoveItem(value), const Icon(Icons.close))
                            )
                          ]
                        )
                      );
                },
              ),
            ),
          )
        ]
    );
  }

}