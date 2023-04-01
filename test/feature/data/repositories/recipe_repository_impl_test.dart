import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:recipe_finder_clean/core/network/network_info.dart';
import 'package:recipe_finder_clean/feature/data/datasources/recipe_local_data_source.dart';
import 'package:recipe_finder_clean/feature/data/datasources/recipe_remote_data_source.dart';
import 'package:recipe_finder_clean/feature/data/repositories/recipe_repository_impl.dart';

import 'recipe_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<RecipeRemoteDataSource>(),
  MockSpec<RecipeLocalDataSource>(),
  MockSpec<NetworkInfo>()
])
void main() {
  RecipeRepositoryImpl repository;

  MockRecipeRemoteDataSource mockRecipeRemoteDataSource;
  MockRecipeLocalDataSource mockRecipeLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  mockRecipeRemoteDataSource = MockRecipeRemoteDataSource();
  mockRecipeLocalDataSource = MockRecipeLocalDataSource();
  mockNetworkInfo = MockNetworkInfo();

  repository = RecipeRepositoryImpl(
      localDataSource: mockRecipeLocalDataSource,
      remoteDataSource: mockRecipeRemoteDataSource,
      networkInfo: mockNetworkInfo
  );

  test(
    "should check if the device is online",
      (){
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        repository.getRecipe(["salt", "pepper"]);

        verify(mockNetworkInfo.isConnected);
      }
  );

}

