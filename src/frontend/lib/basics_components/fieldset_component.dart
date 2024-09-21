import 'package:flutter/material.dart';

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
              borderRadius: BorderRadius.circular(10.0),
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
