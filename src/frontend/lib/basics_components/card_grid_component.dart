import 'package:flutter/material.dart';
import 'package:frontend/basics_components/text_util.dart';

class CardGridComponent extends StatelessWidget {

  final List<Widget> info;
  final List<Widget> actions;

  const CardGridComponent(this.info, this.actions, {super.key});

  @override
  Widget build(BuildContext context) {
    return _buildInfoCardWithActions();
  }

  Card _buildInfoCardWithActions() {
    return Card(
      margin: const EdgeInsets.fromLTRB(2.0, 0.5, 2.0, 0.5),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  for (final Widget info in info)
                    Row(children: [info],),
                ],
              ),
            ),
            Column(
              children: [
                Row(children: [
                  for (final Widget action in actions)
                    action
                  ],
                ),
              ]
            ),
          ],
        ),
      ),
    );
  }



}