import 'package:flutter/material.dart';
import 'package:frontend/basics_components/default_buttons.dart';
import 'package:frontend/basics_components/text_util.dart';
import 'package:frontend/basics_components/default_colors.dart';
import 'package:frontend/l10n/l10n_service.dart';
import 'package:go_router/go_router.dart';

class Home extends StatelessWidget {
  final Widget child;
  const Home(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    L10nService(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: DefaultColors.blue1,
          leading: const Icon(Icons.home),
          iconTheme: const IconThemeData(color: DefaultColors.white1),
          title: Center(child: TextUtil.title(L10nService.l10n().appTitle)),
        ),
        body: child);
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextUtil.subTitle(L10nService.l10n().mainMenuTitle,
            foreground: DefaultColors.black1),
      ),
      body: GridView.extent(
        maxCrossAxisExtent: 400,
        childAspectRatio: 4,
        children: [
          DefaultButtons.mainMenuButton(
            () => context.go('/finances/account-category'),
            L10nService.l10n().accountCategoryTitle,
            const Icon(Icons.account_balance_sharp)
          ),
          DefaultButtons.mainMenuButton(
                  () => context.go('/finances/persons'),
              L10nService.l10n().personTitle,
              const Icon(Icons.people)
          ),
        ],
      )
    );
  }
}
