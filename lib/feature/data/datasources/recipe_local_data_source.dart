import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/recipe_model.dart';

abstract class RecipeLocalDataSource{
  Future<List<RecipeModel>> getLastRecipeList();

  Future<void> cacheRecipeList(List<RecipeModel> recipeList);
}

const cachedRecipeListKey = "CACHED_RECIPE_LIST";
class RecipeLocalDataSourceImpl implements RecipeLocalDataSource{

  final SharedPreferences sharedPreferences;

  RecipeLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheRecipeList(List<RecipeModel> recipeList) async {

  }

  @override
  Future<List<RecipeModel>> getLastRecipeList() async {
    final jsonString = sharedPreferences.getString(cachedRecipeListKey);
    final List dataList = jsonDecode(jsonString!);

    return Future.value(
      List<RecipeModel>.from(dataList.map((e) {
        return RecipeModel.fromJson(e);
      }))
    );
  }

}