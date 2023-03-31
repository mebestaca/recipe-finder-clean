import 'package:dartz/dartz.dart';
import 'package:recipe_finder_clean/core/error/failure.dart';
import 'package:recipe_finder_clean/feature/domain/entities/recipe.dart';
import 'package:recipe_finder_clean/feature/domain/repositories/recipe_repository.dart';

class RecipeRepositoryImpl extends RecipeRepository{
  @override
  Future<Either<Failure, List<Recipe>>> getRecipe(List<String> ingredients) async {
    return const Right(
       [Recipe(imageUrl: "", ingredients: [], title: "")]
    );
  }
}