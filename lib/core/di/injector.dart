import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_task/layers/data/app_repository_impl.dart';
import 'package:posts_task/layers/data/source/local/local_storage.dart';
import 'package:posts_task/layers/data/source/local/realm_config.dart';
import 'package:posts_task/layers/data/source/remote/app_api.dart';
import 'package:posts_task/layers/data/source/remote/dio_factory.dart';
import 'package:posts_task/layers/data/source/remote/network_info.dart';
import 'package:posts_task/layers/domain/repository/app_repository.dart';
import 'package:posts_task/layers/domain/usecase/posts/posts_usecase.dart';
import 'package:posts_task/layers/presentation/pages/home/controller/home_cubit.dart';
import 'package:posts_task/layers/presentation/pages/recipesList/controller/recipes_cubit.dart';

GetIt getIt = GetIt.instance;

Future<void> initializeGetIt() async {
  // ---------------------------------------------------------------------------
  // DATA Layer
  // ---------------------------------------------------------------------------
  // NetworkInfo
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(InternetConnectionChecker()),);
  getIt.registerFactory<LocalStorage>(() => LocalStorageImpl(realmDB: RealmConfig.instance.database,),);
  // dio factory
  getIt.registerLazySingleton<DioFactory>(() => DioFactory(getIt()));
  Dio dio = await getIt<DioFactory>().getDio();
  //app service client
  getIt.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // getIt.registerLazySingleton<Api>(() => ApiImpl());

  getIt.registerFactory<AppRepository>(
    () => AppRepositoryImpl(
      api: getIt(),
      networkInfo: getIt(),
    ),
  );

  // ---------------------------------------------------------------------------
  // DOMAIN Layer
  // ---------------------------------------------------------------------------
  getIt.registerFactory(
    () => RecipesUseCase(
      repository: getIt(), localStorage: getIt(),
    ),
  );

  // // ---------------------------------------------------------------------------
  // // PRESENTATION Layer
  // // ---------------------------------------------------------------------------
  getIt.registerFactory(
    () => HomeCubit(),
  );
  getIt.registerFactory(
    () => RecipesCubit(getIt()),
  );
}
