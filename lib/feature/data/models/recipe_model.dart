import 'package:recipe_finder_clean/feature/domain/entities/recipe.dart';

import 'ingredients_model.dart';

class RecipeModel extends Recipe{

  final List<IngredientsModel> ingredients;

  const RecipeModel({
    required super.title,
    required super.imageUrl,
    required this.ingredients,
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

  Map<String, dynamic> toJson() => {
    "title" : title,
    "image" : imageUrl,
    "missedIngredients" : List<dynamic>.from(ingredients.map((e) => e.toJson()))
  };
}