import 'package:chases_scroll/src/config/router/router.dart';
import 'package:chases_scroll/src/services/storage_service.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

GetIt locator = GetIt.instance;

Future setUpLocator() async {
  locator.registerSingleton<GoRouter>(router());
  var instance = await LocalStorageService.getInstance();
  locator.registerSingleton<LocalStorageService>(instance);
}
