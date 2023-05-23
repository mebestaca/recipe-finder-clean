import 'package:dartz/dartz.dart';
import 'package:recipe_finder_clean/core/error/exception.dart';
import 'package:recipe_finder_clean/core/error/failure.dart';
import 'package:recipe_finder_clean/feature/data/datasources/recipe_local_data_source.dart';
import 'package:recipe_finder_clean/feature/data/datasources/recipe_remote_data_source.dart';
import 'package:recipe_finder_clean/feature/domain/repositories/recipe_repository.dart';

import '../../../core/network/network_info.dart';
import '../models/recipe_model.dart';

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
  Future<Either<Failure, List<RecipeModel>>> getRecipe(List<String> ingredients) async {
    if (await networkInfo.isConnected) {
      try{
        final recipeList = await remoteDataSource.getRecipe(ingredients);
        localDataSource.cacheRecipeList(recipeList);
        return Right(recipeList);
      }
      on ServerException{
        return Left(ServerFailure());
      }
    }
    else {
      try {
        final recipeList = await localDataSource.getLastRecipeList();
        return Right(recipeList);
      }
      on CacheException{
        return Left(CacheFailure());
      }
    }
  }
}