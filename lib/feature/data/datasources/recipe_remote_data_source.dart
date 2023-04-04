import '../models/recipe_model.dart';

abstract class RecipeRemoteDataSource{
  Future<List<RecipeModel>> getRecipe(List<String> ingredients);
}