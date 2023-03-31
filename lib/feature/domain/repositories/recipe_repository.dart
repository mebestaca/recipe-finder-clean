import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../entities/recipe.dart';

abstract class RecipeRepository {
  Future<Either<Failure, List<Recipe>>> getRecipe(List<String> ingredients);
}