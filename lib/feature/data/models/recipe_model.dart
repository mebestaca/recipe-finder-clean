import 'package:recipe_finder_clean/feature/domain/entities/recipe.dart';

import 'ingredients_model.dart';

class RecipeModel extends Recipe{
  const RecipeModel({
    required super.title,
    required super.imageUrl,
    required super.ingredients
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
        title: json["title"],
        imageUrl: json["image"],
        ingredients: List<IngredientsModel>.from(
            json["missedIngredients"].map((x) => IngredientsModel.fromJson(x))
        ),
    );
  }
}