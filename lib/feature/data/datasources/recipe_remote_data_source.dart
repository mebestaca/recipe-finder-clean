import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../domain/entities/recipe.dart';

abstract class RecipeRemoteDataSource{
  Future<Either<Failure, List<Recipe>>> getRecipe(List<String> ingredients);
}