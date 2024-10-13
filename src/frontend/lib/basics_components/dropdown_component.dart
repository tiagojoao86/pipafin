import 'package:flutter/material.dart';
import 'package:frontend/basics_components/component_pattern.dart';
import 'package:frontend/basics_components/default_colors.dart';
import 'package:frontend/basics_components/text_util.dart';

class DropdownComponent<T> extends StatefulWidget {

  final dynamic value;
  final String? Function(dynamic value) validator;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChange;
  final String labelText;
  final int flex;
  final double height;
  final double width;
  final EdgeInsets margin;
  final bool resetAfterChange;

  const DropdownComponent(this.value, this.validator, this.items, this.onChange,
      this.labelText,
      {super.key, this.flex = 10, this.height = 0, this.width = 0, this.margin = const EdgeInsets.fromLTRB(10, 5, 10, 5),
      this.resetAfterChange = false});

  @override
  State<StatefulWidget> createState() {
    return _DropdownComponent<T>();
  }
}

class _DropdownComponent<T> extends State<DropdownComponent<T>> {
  final _dropdownKey = GlobalKey<FormFieldState>();
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        FocusScope.of(context).requestFocus(_focusNode);
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.height > 0 && widget.width > 0) {
      return SizedBox(
          height: widget.height,
          width: widget.width,
          child: _getDropdownButton()
      );
    }

    return
      Flexible(
        flex: widget.flex,
        child: _getDropdownButton()
      );
  }

  Padding _getDropdownButton() {
    return Padding(
      padding: widget.margin,
      child: ButtonTheme(
          child: DropdownButtonFormField<T>(
              key: _dropdownKey,
              focusNode: _focusNode,
              value: widget.value,
              validator: widget.validator,
              items: widget.items,
              selectedItemBuilder: (context) {
                return widget.items.map<Widget>((DropdownMenuItem<T> item) {
                  var text = (item.child as Text).data;
                  return TextUtil(text, foreground: _focusNode.hasFocus ? DefaultColors.secondaryColor : DefaultColors.textColor);
                }).toList();
              },
              iconEnabledColor: DefaultColors.secondaryColor,
              iconDisabledColor: DefaultColors.secondaryColor,
              onChanged: onChange,
              dropdownColor: DefaultColors.secondaryColor,
              style: ComponentPattern.invertedTextStyle,
              decoration: InputDecoration(
                labelText: widget.labelText,
                labelStyle: _focusNode.hasFocus ?
                  ComponentPattern.focusedTextStyle : ComponentPattern.textStyle,
                contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                enabledBorder: ComponentPattern.border,
                border: ComponentPattern.border,
                focusedBorder: ComponentPattern.focusedBorder,
                disabledBorder: ComponentPattern.border,
                errorBorder: ComponentPattern.errorBorder,
                focusedErrorBorder: ComponentPattern.errorBorder,
                errorStyle: ComponentPattern.errorTextStyle,
              )
          )
      ),
    );
  }

  onChange(value) {
    widget.onChange(value);
    if (widget.resetAfterChange == true) {
      setState(() {
        if (_dropdownKey.currentState != null) {
          _dropdownKey.currentState!.reset();
        }
      });
    }
  }
}