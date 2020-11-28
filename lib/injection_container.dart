import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/sub_reddit/data/data_source/sub_reddit_local_data_source.dart';
import 'features/sub_reddit/data/data_source/sub_reddit_remote_data_source.dart';
import 'features/sub_reddit/data/repositories/sub_reddit_repository.dart';
import 'features/sub_reddit/domain/repositories/sub_reddit_repository.dart';
import 'features/sub_reddit/domain/usecases/get_sub_reddit.dart';
import 'features/sub_reddit/presentation/bloc/sub_reddit_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => SubRedditBloc(getSubReddit: sl()));

  sl.registerLazySingleton(() => GetSubReddit(sl()));

  sl.registerLazySingleton<SubRedditRepository>(() => SubRedditRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<SubRedditLocalDataSource>(
      () => SubRedditLocalDataSourceIml(sharedPreferences: sl()));

  sl.registerLazySingleton<SubRedditRemoteDataSource>(
      () => SubRedditRemoteDataSourceIml(client: sl()));

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
