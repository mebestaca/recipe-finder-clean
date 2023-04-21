import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:recipe_finder_clean/feature/data/models/ingredients_model.dart';
import 'package:recipe_finder_clean/feature/data/models/recipe_model.dart';
import 'package:recipe_finder_clean/feature/domain/usecases/get_recipe.dart';
import 'package:recipe_finder_clean/feature/presentation/bloc/recipe/recipe_list_bloc.dart';

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

      test("should get data from the getRecipeList usecase",
        () async {
          when(mockGetRecipe(any))
              .thenAnswer((_) async => const Right(tRecipeModel));

          bloc.add(GetRecipeForRecipeList(ingredients));
          await untilCalled(mockGetRecipe(any));

          verify(mockGetRecipe(Params(ingredients:  ingredients)));
        }
      );

      test("should emit [Loading, Loaded] when data is fetched successfully",
        () async* {
          when(mockGetRecipe(any))
            .thenAnswer((_) async => const Right(tRecipeModel));

          final expected = [
            EmptyRecipeList(),
            LoadingRecipeList(),
            LoadedRecipeList()
          ];

          expectLater(bloc, emitsInOrder(expected));
          bloc.add(GetRecipeForRecipeList(ingredients));
        }
      );
    }
  );
}