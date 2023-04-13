import '../../../keys/keys.dart';
import '../models/recipe_model.dart';
import 'package:http/http.dart' as http;

abstract class RecipeRemoteDataSource{
  Future<List<RecipeModel>> getRecipe(List<String> ingredients);
}

class RecipeRemoteDataSourceImpl implements RecipeRemoteDataSource{

  final http.Client client;

  const RecipeRemoteDataSourceImpl({required this.client});

  @override
  Future<List<RecipeModel>> getRecipe(List<String> ingredients) async {
    Map<String, String> data= {
      "ingredients" : ingredients.toString(),
      "apiKey" : apiKey,
      "number" : "100"
    };
    final uri = Uri.http('api.spoonacular.com', '/recipes/findByIngredients', data);
    final response = await client.get(uri, headers: {"Content-Type" : "application/json"});
    return Future.value([]);
  }
}