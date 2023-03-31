import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_finder_clean/feature/data/models/ingredients_model.dart';
import 'package:recipe_finder_clean/feature/data/models/recipe_model.dart';
import 'package:recipe_finder_clean/feature/domain/entities/ingredients.dart';
import 'package:recipe_finder_clean/feature/domain/entities/recipe.dart';

import '../../../fixtures/fixture_reader.dart';


void main() {

  const tRecipeModel = RecipeModel(
    title: "test title",
    imageUrl: "image url",
    ingredients: <Ingredients> [
      IngredientsModel(
          name: "salt",
          amount: 1.0,
          unitOfMeasure: "cup",
          imageUrl: "test.url.com"
      ),
    ]
  );

  test('should be a subclass of Recipe entity',
  () async {
    expect(tRecipeModel, isA<Recipe>());
  });

  group('fromJson',
  () {
    test('should return a valid model', () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('recipe.json'));

      final result = RecipeModel.fromJson(jsonMap);

      expect(result, tRecipeModel);
    });
  });

}