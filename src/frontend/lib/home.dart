import 'package:flutter/material.dart';
import 'package:frontend/basics_components/default_buttons.dart';
import 'package:frontend/basics_components/text_util.dart';
import 'package:frontend/basics_components/default_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

AppLocalizations? location;

class Home extends StatelessWidget {
  final Widget child;
  const Home(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    location = AppLocalizations.of(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: DefaultColors.blue1,
          leading: const Icon(Icons.home),
          iconTheme: const IconThemeData(color: DefaultColors.white1),
          title: Center(child: TextUtil.title(location!.appTitle)),
        ),
        body: child);
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    location = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: TextUtil.subTitle(location!.mainMenuTitle,
            foreground: DefaultColors.black1),
      ),
      body: GridView.builder(
        primary: false,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 4),
        itemCount: 1,
        itemBuilder: (ctx, index) => DefaultButtons.mainMenuButton(
                () => context.go('/finances/account-category'),
            location!.accountCategoryTitle,
            const Icon(Icons.account_balance_sharp)),
      ),
    );
  }
}
