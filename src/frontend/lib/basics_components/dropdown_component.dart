import 'package:flutter/material.dart';

class DropdownComponent<T> extends StatelessWidget {

  final dynamic value;
  final String? Function(dynamic value) validator;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChange;
  final String labelText;
  final int flex;

  const DropdownComponent(this.value, this.validator, this.items, this.onChange, this.labelText, {super.key, this.flex = 10});

  @override
  Widget build(BuildContext context) {
    return
      Flexible(
        flex: flex,
        child:
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButtonFormField<T>(
                  value: value,
                  validator: validator,
                  items: items,
                  onChanged: onChange,
                  decoration: InputDecoration(
                    labelText: labelText,
                    border: const OutlineInputBorder(),
                  )
                )
            ),
          )
      );
  }
}