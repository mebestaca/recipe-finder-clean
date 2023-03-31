import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe_finder_clean/core/usecases/usecase.dart';
import 'package:recipe_finder_clean/feature/domain/repositories/recipe_repository.dart';

import '../../../core/error/failure.dart';
import '../entities/recipe.dart';

class GetRecipe extends UseCase<List<Recipe>, Params>{
  RecipeRepository repository;

  GetRecipe(this.repository);

  @override
  Future<Either<Failure, List<Recipe>>> call(
    Params params
  )
  async {
    return await repository.getRecipe(params.ingredients);
  }
}

class Params extends Equatable {
  final List<String> ingredients;

  const Params({required this.ingredients});

  @override
  List<Object?> get props => [ingredients];

}