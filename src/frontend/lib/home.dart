import 'package:flutter/material.dart';
import 'package:frontend/basics_components/default_buttons.dart';
import 'package:frontend/basics_components/default_sizes.dart';
import 'package:frontend/basics_components/snack_bar_service.dart';
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
    SnackBarService(context);
    return Scaffold(
        appBar: AppBar(            
          backgroundColor: DefaultColors.transparent,
          leading: Container(
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: const Icon(Icons.home)
          ),
          iconTheme: const IconThemeData(color: DefaultColors.textColor),
          
          title: Center(child: TextUtil.title(L10nService.l10n().appTitle,
            foreground: DefaultColors.textColor,)),
        ),
        body: Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: child
              )
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextUtil.subTitle(
            L10nService.l10n().mainMenuTitle,
            foreground: DefaultColors.textColor
        ),
        backgroundColor: DefaultColors.transparency,
        toolbarHeight: DefaultSizes.headerHeight,
        shape: OutlineInputBorder(
          borderSide: const BorderSide(color: DefaultColors.transparent, width: 0,),
          borderRadius: BorderRadius.circular(DefaultSizes.borderRadius)
        ),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        decoration: const BoxDecoration(
          color: DefaultColors.transparency,
          borderRadius: BorderRadius.all(Radius.circular(DefaultSizes.borderRadius)),
        ),
        child:
          GridView.extent(
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
          ),
      )
    );
  }
}
