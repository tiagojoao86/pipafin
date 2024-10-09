import 'package:flutter/material.dart';
import 'package:frontend/basics_components/default_colors.dart';
import 'package:frontend/basics_components/default_sizes.dart';

class CardGridComponent extends StatelessWidget {

  final List<Widget> info;
  final List<Widget> actions;

  const CardGridComponent(this.info, this.actions, {super.key});

  @override
  Widget build(BuildContext context) {
    return _buildInfoCardWithActions();
  }

  Container _buildInfoCardWithActions() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 1, 15, 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DefaultSizes.borderRadius),
        color: DefaultColors.itemTransparent
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 8, 5),
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