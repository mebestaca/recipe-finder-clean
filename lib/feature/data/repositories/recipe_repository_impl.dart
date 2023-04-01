import 'package:dartz/dartz.dart';
import 'package:recipe_finder_clean/core/error/failure.dart';
import 'package:recipe_finder_clean/feature/data/datasources/recipe_local_data_source.dart';
import 'package:recipe_finder_clean/feature/data/datasources/recipe_remote_data_source.dart';
import 'package:recipe_finder_clean/feature/domain/entities/recipe.dart';
import 'package:recipe_finder_clean/feature/domain/repositories/recipe_repository.dart';

import '../../../core/network/network_info.dart';

class RecipeRepositoryImpl extends RecipeRepository{

  final RecipeRemoteDataSource remoteDataSource;
  final RecipeLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  RecipeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo
  });

  @override
  Future<Either<Failure, List<Recipe>>> getRecipe(List<String> ingredients) async {
    networkInfo.isConnected;
    return const Right(
       [Recipe(imageUrl: "", ingredients: [], title: "")]
    );
  }
}