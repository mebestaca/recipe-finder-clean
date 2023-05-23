import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_finder_clean/feature/data/models/ingredients_model.dart';
import 'package:recipe_finder_clean/feature/data/models/recipe_model.dart';
import 'package:recipe_finder_clean/feature/domain/entities/recipe.dart';

import '../../../fixtures/fixture_reader.dart';


void main() {

  const tRecipeModel = RecipeModel(
    title: "test title",
    imageUrl: "image url",
    ingredients: [
      IngredientsModel(
          name: "salt",
          amount: 1.0,
          unitOfMeasure: "cup",
          imageUrl: "test.url.com"
      ),
    ], id: 1
  );

  test('should be a subclass of Recipe entity',
  () async {
    expect(tRecipeModel, isA<Recipe>());
  });

  group('fromJson',
  () {
    test('should return a valid model', () async {
      final List dataList = jsonDecode(fixture('recipe.json'));
      final Map<String, dynamic> jsonMap = jsonDecode(jsonEncode(dataList[0]));
      final result = RecipeModel.fromJson(jsonMap);
      expect(result, tRecipeModel);
    });
  });


  group('toJson',
      () {
        test("should return a json map containing proper data",
            () async {
              const tRecipeModel = RecipeModel(
                title: "test title",
                imageUrl: "image url",
                ingredients: [
                  IngredientsModel(
                      name: "ingredient1",
                      amount: 1,
                      unitOfMeasure: "cup",
                      imageUrl: "url 1"
                  ),
                  IngredientsModel(
                      name: "ingredient2",
                      amount: 2,
                      unitOfMeasure: "cup",
                      imageUrl: "url 2"
                  ),
                ], id: 1
              );
              final result = tRecipeModel.toJson();

              final expectedJsonMap = {
                "title" : "test title",
                "image" : "image url",
                "missedIngredients" : [
                  {
                    "name": "ingredient1",
                    "amount": 1,
                    "originalName": "cup",
                    "image": "url 1"
                  },
                  {
                    "name": "ingredient2",
                    "amount": 2,
                    "originalName": "cup",
                    "image": "url 2"
                  },
                ]
              };

              expect(result, expectedJsonMap);

            }
        );
      }
  );
}