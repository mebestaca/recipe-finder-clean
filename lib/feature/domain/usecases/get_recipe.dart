import 'package:dartz/dartz.dart';
import 'package:recipe_finder_clean/feature/domain/repositories/recipe_repository.dart';

import '../../../core/error/failure.dart';
import '../entities/recipe.dart';

class GetRecipe{
  RecipeRepository repository;

  GetRecipe(this.repository);

  Future<Either<Failure, Recipe>> execute({
    required List<String> ingredients
  })
  async {
    return await repository.getRecipe(ingredients);
  }

}