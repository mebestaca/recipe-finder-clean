import "dart:convert";

import "package:flutter_test/flutter_test.dart";
import "package:mockito/annotations.dart";
import "package:mockito/mockito.dart";
import "package:recipe_finder_clean/core/error/exception.dart";
import "package:recipe_finder_clean/feature/data/datasources/recipe_local_data_source.dart";
import "package:recipe_finder_clean/feature/data/models/ingredients_model.dart";
import "package:recipe_finder_clean/feature/data/models/recipe_model.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../../../fixtures/fixture_reader.dart";
import "recipe_local_data_source_test.mocks.dart";

@GenerateNiceMocks([MockSpec<SharedPreferences>()])
void main() {
  late RecipeLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = RecipeLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group("getLastRecipeList", () {
    final List dataList = jsonDecode(fixture("recipe_cached.json"));
    final tRecipeListModel = List<RecipeModel>.from(dataList.map((e) {
      return RecipeModel.fromJson(e);
    }));

    test("should return List<RecipeModel> from SharedPreferences when there is one in the cache", () async {
      when(mockSharedPreferences.getString(any))
        .thenReturn(fixture("recipe_cached.json"));
      final result = await dataSource.getLastRecipeList();
      verify(mockSharedPreferences.getString(cachedRecipeListKey));
      expect(result, equals(tRecipeListModel));
    });

    test("should throw a CacheException when there is not a cache value", () async {
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      final call = dataSource.getLastRecipeList;
      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group("cacheRecipeList", () {
    final List<RecipeModel> tRecipeList = [ const RecipeModel(
        title: "test'",
        imageUrl: "test url",
        ingredients: [IngredientsModel(
            name: "test name",
            amount: 1,
            unitOfMeasure: "cup",
            imageUrl: "image url")],
            id: 1)];

    test("should call SharedPreferences to cache the data", () {
      dataSource.cacheRecipeList(tRecipeList);
      List<Map<String, dynamic>> dataList = tRecipeList.map((e) => e.toJson()).toList();
      final String expectedJsonString = jsonEncode(dataList);
      verify(mockSharedPreferences.setString(cachedRecipeListKey, expectedJsonString));
    });
  });

}