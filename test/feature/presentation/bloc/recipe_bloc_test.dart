import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:recipe_finder_clean/core/error/failure.dart';
import 'package:recipe_finder_clean/feature/data/models/ingredients_model.dart';
import 'package:recipe_finder_clean/feature/data/models/recipe_model.dart';
import 'package:recipe_finder_clean/feature/domain/usecases/get_recipe.dart';
import 'package:recipe_finder_clean/feature/presentation/bloc/recipe/recipe_list_bloc.dart';
import 'package:bloc_test/bloc_test.dart';

import 'recipe_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<GetRecipe>()])
void main() {
  late RecipeListBloc bloc;
  late MockGetRecipe mockGetRecipe;

  setUp(() {
    mockGetRecipe = MockGetRecipe();
    bloc = RecipeListBloc(getRecipe: mockGetRecipe);
  });

  test("should return Empty as initial state", () {
    expect(bloc.state, EmptyRecipeList());
  });

  group("getRecipeList",
    () {
      List<String> ingredients = ["salt", "pepper"];
      const List<RecipeModel> tRecipeModel = [RecipeModel(
          title: "test'",
          imageUrl: "test url",
          ingredients: [IngredientsModel(
              name: "test name",
              amount: 1,
              unitOfMeasure: "cup",
              imageUrl: "image url")])];

      blocTest("should get data from the getRecipeList usecase",
        build: () => bloc,
        setUp: () => when(mockGetRecipe(any))
            .thenAnswer((_) async => const Right(tRecipeModel)),
        act: (bloc) => bloc.add(GetRecipeForRecipeList(ingredients)),
        verify: (_) async {
          verify(mockGetRecipe(Params(ingredients:  ingredients)));
        }
      );

      blocTest("should emit [Loading, Loaded] when data is fetched successfully",
        build: () => bloc,
        setUp: () => when(mockGetRecipe(any))
            .thenAnswer((_) async => const Right(tRecipeModel)),
        act: (bloc) => bloc.add(GetRecipeForRecipeList(ingredients)),
        expect: () => [
          LoadingRecipeList(),
          const LoadedRecipeList(tRecipeModel)
        ]
      );

      blocTest("should emit [Loading, Error] when data is fetched unsuccessfully",
        build: () => bloc,
        setUp: () => when(mockGetRecipe(any))
            .thenAnswer((_) async => Left(CacheFailure())),
        act: (bloc) => bloc.add(GetRecipeForRecipeList(ingredients)),
        expect: () => [
          LoadingRecipeList(),
          const ErrorRecipeList(message: CACHE_FAILURE_MESSAGE)
        ]
      );

      blocTest("should emit [Loading, Error] with proper message for the error when getting data fails",
        build: () => bloc,
        setUp: () => when(mockGetRecipe(any))
            .thenAnswer((_) async => Left(ServerFailure())),
        act: (bloc) => bloc.add(GetRecipeForRecipeList(ingredients)),
        expect: () => [
          LoadingRecipeList(),
          const ErrorRecipeList(message: SERVER_FAILURE_MESSAGE)
        ]
      );
    }
  );
}