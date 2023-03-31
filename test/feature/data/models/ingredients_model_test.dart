import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_finder_clean/feature/data/models/ingredients_model.dart';
import 'package:recipe_finder_clean/feature/domain/entities/ingredients.dart';

import '../../../fixtures/fixture_reader.dart';

void main(){

   IngredientsModel tIngredients = const IngredientsModel(
      name: "salt",
      amount: 1.0,
      unitOfMeasure: "cup",
      imageUrl: "test.url.com"
  );

  test(
      'should be a subclass of ingredients entity',
  () {
      expect(tIngredients, isA<Ingredients>());
  });


  group('fromJson',
  () {
    test('should return a valid model', () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('ingredients.json'));

      final result = IngredientsModel.fromJson(jsonMap);

      expect(result, tIngredients);
    });
  });

}