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
      imageUrl: "test.url.com",
      original: "cup"
  );

  test(
      'should be a subclass of ingredients entity',
  () {
      expect(tIngredients, isA<Ingredients>());
  });


  group('fromJson',
  () {
    test('should return a valid model', () async {
      final List dataList = jsonDecode(fixture('ingredients.json'));
      final Map<String, dynamic> jsonMap = jsonDecode(jsonEncode(dataList[0]));
      final result = IngredientsModel.fromJson(jsonMap);
      expect(result, tIngredients);
    });
  });

  group('toJson',
    () {
      test("should return a Json containing the proper data", () {
        const tIngredientsModel = IngredientsModel(
          name: "test",
          amount: 1.0,
          unitOfMeasure: "cup",
          imageUrl: "testUrl",
          original: "cup"
        );

        final result = tIngredientsModel.toJson();

        final expectedJsonMap = {
          "name" : "test",
          "amount" : 1.0,
          "originalName" : "cup",
          "image" : "testUrl"
        };

        expect(result, expectedJsonMap);

      });
    }
  );

}