import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:recipe_finder_clean/core/network/network_info.dart';
import 'package:recipe_finder_clean/feature/data/datasources/recipe_local_data_source.dart';
import 'package:recipe_finder_clean/feature/data/datasources/recipe_remote_data_source.dart';
import 'package:recipe_finder_clean/feature/data/models/recipe_model.dart';
import 'package:recipe_finder_clean/feature/data/repositories/recipe_repository_impl.dart';
import 'package:recipe_finder_clean/feature/domain/entities/ingredients.dart';

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

  group(
    "getRecipe",
      () {
        List<String> ingredients = ["salt", "pepper"];
        const tRecipeModel = RecipeModel(
            title: "test'",
            imageUrl: "test url",
            ingredients: [Ingredients(
                name: "test name",
                amount: 1,
                unitOfMeasure: "cup",
                imageUrl: "image url")]);

        test(
          "should check if the device is online",
              () {
            when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
            repository.getRecipe(ingredients);
            verify(mockNetworkInfo.isConnected);
          }
        );

        group("device is online",
            () {
              setUp(() {
                when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
              });
              test("should return remote data when the call to remote data source is successful",
                      () async {
                    when(mockRecipeRemoteDataSource.getRecipe(ingredients))
                        .thenAnswer((_) async => const Right([tRecipeModel]));
                    final result = await repository.getRecipe(ingredients);
                    verify(mockRecipeRemoteDataSource.getRecipe(ingredients));
                    expect(result, equals(const Right([tRecipeModel])));
                  }
              );
            }
        );
      }
  );
}

