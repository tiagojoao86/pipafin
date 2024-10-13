import 'package:flutter/material.dart';
import 'package:frontend/basics_components/default_buttons.dart';
import 'package:frontend/basics_components/default_colors.dart';
import 'package:frontend/basics_components/default_sizes.dart';
import 'package:frontend/basics_components/dropdown_component.dart';
import 'package:frontend/basics_components/text_form_component.dart';
import 'package:frontend/basics_components/text_util.dart';

class MultiSelectComponent<T> extends StatefulWidget {
  final String labelText;
  final List<DropdownMenuItem<T>> items;
  final List<T> selectedItems;
  final void Function(dynamic value) onSelectItem;
  final void Function(dynamic value) onRemoveItem;
  final int itemsPerRow;

  const MultiSelectComponent(this.labelText, this.items, this.onSelectItem, this.onRemoveItem, this.selectedItems, {super.key, this.itemsPerRow = 3});

  @override
  State<StatefulWidget> createState() {
    return _MultiSelectComponentState();
  }

}

class _MultiSelectComponentState<T> extends State<MultiSelectComponent<T>> {

  @override
  Widget build(BuildContext context) {

    return
      Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child:
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownComponent<T>(
                null,
                TextFormComponent.emptyValidator,
                widget.items,
                onChange,
                widget.labelText,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                resetAfterChange: true
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                padding: widget.selectedItems.isNotEmpty ? const EdgeInsets.fromLTRB(5, 5, 5, 5) : EdgeInsets.zero,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                      bottomStart: Radius.circular(DefaultSizes.borderRadius),
                      bottomEnd: Radius.circular(DefaultSizes.borderRadius)
                  ),
                  color: DefaultColors.transparency
                ),
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: widget.selectedItems.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: widget.itemsPerRow,
                    childAspectRatio: 4,
                  ),
                  itemBuilder: (context, index) {
                    var item = widget.selectedItems.elementAt(index);
                    return ItemMultiSelectComponent(item.toString(), () => removeItem(item));
                  },
                ),
            ),),
          ],
        ),
      );
  }

  onChange(item) {
    setState(() {
      if (!widget.selectedItems.contains(item)) {
        widget.selectedItems.add(item);
      }
    });

    widget.onSelectItem(item);
  }

  removeItem(item) {
    setState(() {
      if (widget.selectedItems.contains(item)) {
        widget.selectedItems.remove(item);
      }
    });
    widget.onRemoveItem(item);
  }
}

class ItemMultiSelectComponent extends StatelessWidget {
  
  final String text;
  final VoidCallback action;
  final IconData buttonIcon;
  
  const ItemMultiSelectComponent(this.text, this.action, {super.key, this.buttonIcon = Icons.close});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
      padding: const EdgeInsets.fromLTRB(10, 0, 2, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DefaultSizes.borderRadius),
        color: DefaultColors.itemTransparent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 9,
            child: TextUtil(text)
          ),
          Flexible(
              flex: 3,
              child: DefaultButtons.transparentButton(
                action,
                Icon(buttonIcon),
                foregroundColor: DefaultColors.textColor,
              ),
          ),
        ],
      ),
    );  
  }
  
}