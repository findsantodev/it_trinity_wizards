import 'package:mobx/mobx.dart';
import 'package:trinity_wizards/src/flavor/flavor.dart';
import 'package:trinity_wizards/src/i18n/localization_store.dart';
import 'package:trinity_wizards/src/navigation/navigation_service.dart';

part 'splash_store.g.dart';

class SplashStore = _SplashStore with _$SplashStore;

abstract class _SplashStore with Store {
  final LocalizationStore _localizationStore;
  final NavigationService _navigationService;
  final FlavorConfig _flavorConfig;
  _SplashStore({
    required LocalizationStore localizationStore,
    required NavigationService navigationService,
    required FlavorConfig flavorConfig,
  })  : _localizationStore = localizationStore,
        _navigationService = navigationService,
        _flavorConfig = flavorConfig;

  @observable
  bool isLoading = true;

  @observable
  String errorMessage = "";

  Future initApp() async {
    isLoading = true;

    final localeFuture = _localizationStore.loadLocale();
    final flavorFuture = _flavorConfig.init().then((_) async {});
    // Initialize necessary components
    await Future.wait(
      [
        localeFuture,
        flavorFuture,
        Future.delayed(const Duration(seconds: 2)),
      ],
    );

    return;
  }

  @action
  void onRetryClicked() {
    initApp();
  }
}
