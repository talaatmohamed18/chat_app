import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/datasources/auth_local_datasource.dart';
import '../../features/auth/data/datasources/auth_remote_database.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repo/auth_repo_impl.dart';
import '../../features/auth/presentation/blocs/auth_cubit.dart';
import '../../features/auth/presentation/repo/auth_repo.dart';
import '../services/cache_service.dart';
import '../services/remote_auth_service.dart';
import '../services/remote_database_service.dart';

final sl = GetIt.instance;

void initServiceLocator() {
  // Cubits
  sl.registerFactory(() => AuthCubit(sl()));
  // sl.registerFactory(() => ChatCubit(sl()));

  // sl.registerFactory<ChatRoomCubit>(
  //   () => ChatRoomCubit(chatRepository: sl()),
  // );
  // sl.registerFactory(() => SearchUsersBloc(homeRepository: sl()));

  // sl.registerFactory(() => DrawingBoardBloc(sl()));

  // Repositories
  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      authLocalDataSource: sl(),
      authRemoteDataSource: sl(),
      authRemoteDatabase: sl(),
    ),
  );
  // sl.registerLazySingleton<ChatRepository>(
  //   () => ChatRepositoryImpl(chatRemoteDataSource: sl()),
  // );

  // sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(
  //       homeRemoteDataSource: sl(),
  //     ));

  // sl.registerLazySingleton<DrawingBoardRepository>(
  //     () => DrawingBoardRepositoryImpl(
  //           drawingBoardRemoteDataSource: sl(),
  //         ));

  // DataSources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AuthRemoteDatabase>(
    () => AuthRemoteDatabaseImpl(sl()),
  );
  // sl.registerLazySingleton<ChatRemoteDataSource>(
  //     () => ChatRemoteDataSourceImpl(remoteDatabase: sl()));
  // sl.registerLazySingleton<HomeRemoteDataSource>(
  //     () => HomeRemoteDataSourceImpl(remoteDatabase: sl()));
  // sl.registerLazySingleton<DrawingBoardRemoteDataSource>(
  //     () => DrawingBoardRemoteDataSourceImpl(remoteDatabase: sl()));

  // Services
  sl.registerLazySingleton<RemoteAuthService>(
    () => RemoteAuthServiceImpl(FirebaseAuth.instance),
  );
  sl.registerLazySingleton<RemoteDatabaseService>(
    () => RemoteDatabaseServiceImpl(FirebaseFirestore.instance),
  );
  sl.registerLazySingleton<CacheService>(() => CacheServiceImpl());
}
