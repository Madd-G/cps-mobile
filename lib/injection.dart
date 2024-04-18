import 'package:cps_mobile/src/data/datasources/city_local_data_source.dart';
import 'package:cps_mobile/src/data/datasources/city_remote_datasources.dart';
import 'package:cps_mobile/src/data/datasources/db/database_helper.dart';
import 'package:cps_mobile/src/data/datasources/user_local_data_source.dart';
import 'package:cps_mobile/src/data/datasources/user_remote_datasources.dart';
import 'package:cps_mobile/src/data/repositories/city_repository_impl.dart';
import 'package:cps_mobile/src/data/repositories/user_repository_impl.dart';
import 'package:cps_mobile/src/domain/repositories/city_repository.dart';
import 'package:cps_mobile/src/domain/repositories/user_repository.dart';
import 'package:cps_mobile/src/domain/usecases/add_user.dart';
import 'package:cps_mobile/src/domain/usecases/get_cities.dart';
import 'package:cps_mobile/src/domain/usecases/get_filtered_user.dart';
import 'package:cps_mobile/src/domain/usecases/get_users.dart';
import 'package:cps_mobile/src/domain/usecases/search_user.dart';
import 'package:cps_mobile/src/domain/usecases/sort_users.dart';
import 'package:cps_mobile/src/presentation/bloc/add_user_bloc/add_user_bloc.dart';
import 'package:cps_mobile/src/presentation/bloc/city_bloc/city_list_bloc.dart';
import 'package:cps_mobile/src/presentation/bloc/search_user_bloc/search_user_bloc.dart';
import 'package:cps_mobile/src/presentation/bloc/user_bloc/user_list_bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';

import 'core/common/network_info.dart';
import 'core/common/shared.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _initBloc();
  await _initUseCase();
  await _initRepository();
  await _initDataSource();
  await _initHelper();
  await _initNetworkInfo();
}

Future<void> _initBloc() async {
  sl
    ..registerFactory(() => UserListBloc(sl(), sl(), sl()))
    ..registerFactory(() => SearchUserBloc(sl()))
    ..registerFactory(() => AddUserBloc(sl()))
    ..registerFactory(() => CityBloc(sl()));
}

Future<void> _initUseCase() async {
  sl
    ..registerLazySingleton(() => GetUsers(sl()))
    ..registerLazySingleton(() => SearchUser(sl()))
    ..registerLazySingleton(() => AddUser(sl()))
    ..registerLazySingleton(() => GetCities(sl()))
    ..registerLazySingleton(() => GetFilteredUser(sl()))
    ..registerLazySingleton(() => SortUsers(sl()));
}

Future<void> _initRepository() async {
  sl
    ..registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ),
    )
    ..registerLazySingleton<CityRepository>(
      () => CityRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ),
    );
}

Future<void> _initDataSource() async {
  sl
    ..registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: sl()),
    )
    ..registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl(databaseHelper: sl()),
    )
    ..registerLazySingleton<CityRemoteDataSource>(
      () => CityRemoteDataSourceImpl(client: sl()),
    )
    ..registerLazySingleton<CityLocalDataSource>(
      () => CityLocalDataSourceImpl(databaseHelper: sl()),
    );
}

Future<void> _initHelper() async {
  sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
}

Future<void> _initNetworkInfo() async {
  sl
    ..registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()))
    ..registerLazySingleton(() => ApiService().client)
    ..registerLazySingleton(() => DataConnectionChecker());
}
