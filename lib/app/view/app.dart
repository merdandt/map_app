import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_app/l10n/l10n.dart';

import 'package:map_app/map/view/map_page.dart';
import 'package:map_app_ui/map_app_ui.dart';
import 'package:map_repository/map_repository.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => MapRepository(),
      child: MaterialApp(
        theme: UITheme().lightTheme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const MapPage(),
      ),
    );
  }
}
