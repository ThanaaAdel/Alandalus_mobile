import 'package:alandalos/data/repository/detailsRepo.dart';
import 'package:alandalos/data/repository/notificationRepo.dart';
import 'package:alandalos/screens/auth/login/auth_provider.dart';
import 'package:alandalos/screens/children/child_details/child_details_provider.dart';
import 'package:alandalos/screens/children/child_details/tab/detailsItems/details_Item_provider.dart';
import 'package:alandalos/screens/children/children_provider.dart';
import 'package:alandalos/screens/notification/notification_provider.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'api_service/connectivity/connectivity_status.dart';
import 'core/network_info.dart';
import 'data/app_urls/app_url.dart';
import 'data/datasource/remote/dio/dio_client.dart';
import 'data/datasource/remote/dio/logging_interceptor.dart';
import 'data/model/response/user_model.dart';
import 'data/repository/SaveUserData.dart';
import 'data/repository/auth_repo.dart';
import 'data/repository/student_repo.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerLazySingleton(() => NetworkInfo(getIt()));
  getIt.registerLazySingleton(() => DioClient(AppURL.kBaseURL, getIt(),
      loggingInterceptor: getIt(), sharedPreferences: getIt()));
  getIt.registerLazySingleton(() => AuthProvider(saveUserData: getIt(), authRepo: getIt()));
  getIt.registerLazySingleton(() => ConnectivityProvider());
  getIt.registerLazySingleton(() => StudentsProvider(studentsRepo: getIt()));
  getIt.registerLazySingleton(() => NotificationProvider(notificationRepo: getIt()));
  getIt.registerLazySingleton(() => ChildDetailsProvider(studentRepo: getIt()));
  getIt.registerLazySingleton(() => DetailsItemProvider( detailsRepo: getIt()));
  getIt.registerLazySingleton(() => SaveUserData(sharedPreferences: getIt(), dioClient: getIt()));
  getIt.registerLazySingleton(() => AuthRepo(dioClient: getIt(), saveUserData: getIt()));
  getIt.registerLazySingleton(() => StudentRepo(dioClient: getIt(), saveUserData: getIt()));
  getIt.registerLazySingleton(() => NotificationRepo(dioClient: getIt(), saveUserData: getIt()));
  getIt.registerLazySingleton(() => DetailsRepo(dioClient: getIt(), saveUserData: getIt()));
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => LoggingInterceptor());
  getIt.registerLazySingleton(() => UserModel());
  getIt.registerLazySingleton(() => Connectivity());
}
