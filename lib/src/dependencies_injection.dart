import 'package:get_it/get_it.dart';
import 'package:package_info/package_info.dart';
import 'package:trinity_wizards/src/flavor/flavor.dart';
import 'package:trinity_wizards/src/i18n/localization_store.dart';
import 'package:trinity_wizards/src/navigation/navigation_service.dart';
import 'package:trinity_wizards/src/splash/splash_store.dart';

void setUpDI() {
  GetIt.instance.registerSingleton(PackageInfo.fromPlatform());
  GetIt.instance.registerSingleton<FlavorConfig>(
    FlavorConfig(packageInfoFuture: GetIt.instance.get<Future<PackageInfo>>()),
  );
  GetIt.instance.registerSingleton(LocalizationStore());
  GetIt.instance.registerSingleton(NavigationService());
  GetIt.instance.registerFactory(
    () => SplashStore(
      localizationStore: GetIt.instance.get<LocalizationStore>(),
      navigationService: GetIt.instance.get<NavigationService>(),
      flavorConfig: GetIt.instance.get<FlavorConfig>(),
    ),
  );
}
