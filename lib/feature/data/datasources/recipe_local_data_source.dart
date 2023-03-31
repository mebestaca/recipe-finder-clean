import '../models/recipe_model.dart';

abstract class RecipeLocalDataSource{
  Future<List<RecipeModel>> getLastRecipeList();

  Future<void> cacheRecipeList(List<RecipeModel> recipeList);
}