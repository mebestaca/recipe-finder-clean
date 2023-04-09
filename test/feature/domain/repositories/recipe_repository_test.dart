import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:recipe_finder_clean/feature/domain/entities/recipe.dart';
import 'package:recipe_finder_clean/feature/domain/repositories/recipe_repository.dart';
import 'package:recipe_finder_clean/feature/domain/usecases/get_recipe.dart';

import 'recipe_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<RecipeRepository>()])
void main() {
  GetRecipe usecase;
  MockRecipeRepository mockRecipeRepository;

  final List<String> tIngredients = ["salt", "pepper"];
  const Recipe tRecipe = Recipe(
      title: "test",
      imageUrl: "test url"
  );

  mockRecipeRepository = MockRecipeRepository();
  usecase = GetRecipe(mockRecipeRepository);

  test("should get recipe for the list from recipe repository",
          ()
      async {
        when(mockRecipeRepository.getRecipe(any))
            .thenAnswer((_) async => const Right([tRecipe]));

        final result = await usecase(Params(ingredients: tIngredients));

        expect(result, const Right([tRecipe]));
        verify(mockRecipeRepository.getRecipe(tIngredients));
        verifyNoMoreInteractions(mockRecipeRepository);

      }
  );
}