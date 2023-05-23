import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:recipe_finder_clean/core/network/network_info.dart';
import 'package:recipe_finder_clean/feature/data/datasources/recipe_local_data_source.dart';
import 'package:recipe_finder_clean/feature/data/datasources/recipe_remote_data_source.dart';
import 'package:recipe_finder_clean/feature/data/repositories/recipe_repository_impl.dart';
import 'package:recipe_finder_clean/feature/domain/usecases/get_recipe.dart';
import 'package:recipe_finder_clean/feature/presentation/bloc/recipe/recipe_list_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'feature/domain/repositories/recipe_repository.dart';
import 'feature/presentation/utils/ingredients_list_util.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features
  // Bloc
  sl.registerFactory<RecipeListBloc>(() => RecipeListBloc(
      ingredientsList: sl(),
      getRecipe: sl()
  ));

  // Use cases
  sl.registerLazySingleton(() => GetRecipe(sl()));

  // Repository
  sl.registerLazySingleton<RecipeRepository>(() =>
      RecipeRepositoryImpl(
          remoteDataSource: sl(),
          localDataSource: sl(),
          networkInfo: sl()
      )
  );

  // Data sources
  sl.registerLazySingleton<RecipeRemoteDataSource>(
      () => RecipeRemoteDataSourceImpl(client: sl())
  );
  
  sl.registerLazySingleton<RecipeLocalDataSource>(
      () => RecipeLocalDataSourceImpl(sharedPreferences: sl())
  );

  // Core
  sl.registerLazySingleton(() => IngredientsList());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // Externals
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

}