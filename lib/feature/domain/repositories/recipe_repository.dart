import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../data/models/recipe_model.dart';

abstract class RecipeRepository {
  Future<Either<Failure, List<RecipeModel>>> getRecipe(List<String> ingredients);
}