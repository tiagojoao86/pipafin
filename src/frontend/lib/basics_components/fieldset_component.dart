import 'package:flutter/material.dart';
import 'package:frontend/basics_components/default_sizes.dart';

class FieldSetComponent extends StatelessWidget {
  final List<Widget> children;
  final String labelText;

  const FieldSetComponent(this.children, this.labelText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(9.0, 10.0, 9.0, 1.0),
      child: SizedBox(
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DefaultSizes.borderRadius),
            ),
          ),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: children),
        ),
      )
    );
  }
}
