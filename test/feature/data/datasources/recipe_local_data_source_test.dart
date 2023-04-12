import "dart:convert";

import "package:flutter_test/flutter_test.dart";
import "package:mockito/annotations.dart";
import "package:mockito/mockito.dart";
import "package:recipe_finder_clean/feature/data/datasources/recipe_local_data_source.dart";
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
  });

}