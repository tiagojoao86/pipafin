import 'package:flutter/material.dart';
import 'package:frontend/basics_components/default_colors.dart';
import 'package:frontend/components/account_category_detail_component.dart';
import 'package:frontend/components/account_category_list_component.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend/components/list_component.dart';
import 'package:frontend/home.dart';
import 'package:frontend/model/account_category/account_category_grid.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: DefaultColors.blue2
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

AppLocalizations? location;

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: 'Financial Module - Pipa Group',
        theme: theme,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pt'),
        ],
        routerConfig: buildRouter(context)
    );
  }

  GoRouter buildRouter(BuildContext context) {
    return GoRouter(
        routes: [
          ShellRoute(
              builder: (BuildContext context, GoRouterState state, Widget child) {
                return Home(child);
              },
              routes: _buildRouter(context))
        ]
    );
  }

  List<GoRoute> _buildRouter(BuildContext context) {
    return [
      GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
          routes: [
            GoRoute(
              path: 'finances/account-category',
              builder: (context, state) => const ListComponent<AccountCategoryGrid>(),
            ),
          ]
      ),
    ];
  }
}