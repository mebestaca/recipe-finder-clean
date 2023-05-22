import 'dart:convert';

import 'package:recipe_finder_clean/core/error/exception.dart';

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
    final uri = Uri.https('api.spoonacular.com', '/recipes/findByIngredients', data);
    final response = await client.get(uri, headers: {"Content-Type" : "application/json"});

    if (response.statusCode == 200) {
      final List dataList = jsonDecode(response.body);
      return Future.value(
          List<RecipeModel>.from(dataList.map((e) {
            return RecipeModel.fromJson(e);
          }))
      );
    }
    else {
      throw ServerException();
    }

  }
}