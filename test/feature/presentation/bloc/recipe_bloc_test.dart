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
import 'package:recipe_finder_clean/feature/presentation/utils/ingredients_list_util.dart';

import 'recipe_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<GetRecipe>(), MockSpec<IngredientsList>()])
void main() {
  late RecipeListBloc bloc;
  late MockIngredientsList mockIngredientsList;
  late MockGetRecipe mockGetRecipe;

  setUp(() {
    mockGetRecipe = MockGetRecipe();
    mockIngredientsList = MockIngredientsList();
    bloc = RecipeListBloc(getRecipe: mockGetRecipe, ingredientsList: mockIngredientsList);
  });

  test("should return Empty as initial state", () {
    expect(bloc.state, EmptyRecipeList());
  });

  group("getRecipeList",
    () {
      List<String> tIngredients = ["salt", "pepper"];
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
        act: (bloc) => bloc.add(GetRecipeForRecipeList(tIngredients)),
        verify: (_) async {
          verify(mockGetRecipe(Params(ingredients:  tIngredients)));
        }
      );

      blocTest("should emit [Loading, Loaded] when data is fetched successfully",
        build: () => bloc,
        setUp: () => when(mockGetRecipe(any))
            .thenAnswer((_) async => const Right(tRecipeModel)),
        act: (bloc) => bloc.add(GetRecipeForRecipeList(tIngredients)),
        expect: () => [
          LoadingRecipeList(),
          const LoadedRecipeList(tRecipeModel)
        ]
      );

      blocTest("should emit [Loading, Error] when data is fetched unsuccessfully",
        build: () => bloc,
        setUp: () => when(mockGetRecipe(any))
            .thenAnswer((_) async => Left(CacheFailure())),
        act: (bloc) => bloc.add(GetRecipeForRecipeList(tIngredients)),
        expect: () => [
          LoadingRecipeList(),
          const ErrorRecipeList(message: CACHE_FAILURE_MESSAGE)
        ]
      );

      blocTest("should emit [Loading, Error] with proper message for the error when getting data fails",
        build: () => bloc,
        setUp: () => when(mockGetRecipe(any))
            .thenAnswer((_) async => Left(ServerFailure())),
        act: (bloc) => bloc.add(GetRecipeForRecipeList(tIngredients)),
        expect: () => [
          LoadingRecipeList(),
          const ErrorRecipeList(message: SERVER_FAILURE_MESSAGE)
        ]
      );

      String ingredient = "salt";
      blocTest("should add the ingredient to IngredientsList when the event is AddIngredientsToList",
          build: () => bloc,
          setUp: () => when(mockIngredientsList.addIngredient(any))
              .thenReturn(null),
          act: (bloc) => bloc.add(AddIngredientsToList(ingredient)),
          verify: (_) => {
            verify(mockIngredientsList.addIngredient(ingredient))
          }
      );

      blocTest("should remove the ingredient from IngredientList when the event is RemoveIngredientsFromList",
          build: () => bloc,
          setUp: () => when(mockIngredientsList.removeIngredient(any))
              .thenReturn(null),
          act: (bloc) => bloc.add(RemoveIngredientsFromList(ingredient)),
          verify: (_) => {
            verify(mockIngredientsList.removeIngredient(ingredient))
          }
      );

    }
  );
}