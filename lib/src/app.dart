import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:trinity_wizards/resources/l10n/app_localizations.dart';
import 'package:trinity_wizards/resources/theme.dart';
import 'package:trinity_wizards/src/dependencies_injection.dart';
import 'package:trinity_wizards/src/i18n/localization_store.dart';
import 'package:trinity_wizards/src/i18n/supported_locale.dart';
import 'package:trinity_wizards/src/navigation/navigation_service.dart';

class TrinityWizards extends StatefulWidget {
  const TrinityWizards({super.key});

  @override
  State<TrinityWizards> createState() => _TrinityWizardsState();
}

class _TrinityWizardsState extends State<TrinityWizards>
    with WidgetsBindingObserver {
  late LocalizationStore _localizationStore;

  @override
  void initState() {
    setUpDI();
    _localizationStore = GetIt.instance.get<LocalizationStore>();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp(
        theme: getThemeData(),
        navigatorKey: GetIt.instance.get<NavigationService>().navigatorKey,
        initialRoute: NavigationService.routeSplash,
        onGenerateRoute: GetIt.instance.get<NavigationService>().generateRoute,
        title: 'Trinity Wizards',
        supportedLocales: supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        locale: _localizationStore.locale,
      ),
    );
  }
}
