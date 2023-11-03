import 'package:fcm_demo/core/services/fcm_service.dart';
import 'package:fcm_demo/core/services/network_service.dart';
import 'package:fcm_demo/core/services/push_notification_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
// Register dependencies

  locator.registerLazySingleton<NetworkServiceRepository>(
      () => NetworkServiceRepositoryImpl());
  locator.registerLazySingleton(() => PushNotificationService());
  locator.registerLazySingleton(() => FcmService());
}
