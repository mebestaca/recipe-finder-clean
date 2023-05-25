import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:recipe_finder_clean/core/error/exception.dart';
import 'package:recipe_finder_clean/feature/data/datasources/recipe_remote_data_source.dart';
import 'package:recipe_finder_clean/feature/data/models/ingredients_model.dart';
import 'package:recipe_finder_clean/feature/data/models/recipe_model.dart';
import 'package:recipe_finder_clean/keys/keys.dart';

import '../../../fixtures/fixture_reader.dart';
import 'recipe_remote_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
void main() {
  late RecipeRemoteDataSourceImpl dataSource;
  late MockClient mockClient;

  void setUpMockClientSuccess200() {
    when(mockClient.get(any, headers: anyNamed("headers")))
        .thenAnswer((_) async => http.Response(fixture("recipe.json"), 200));
  }

  void setUpMockClientFailure404() {
    when(mockClient.get(any, headers: anyNamed("headers")))
        .thenAnswer((_) async => http.Response("something went wrong", 404));
  }

  setUp(() {
    mockClient = MockClient();
    dataSource = RecipeRemoteDataSourceImpl(client: mockClient);
  });

  group("getRecipe", () {

    List<String> ingredients = ["salt", "pepper"];
    Map<String, String> data = {
      "ingredients" : ingredients.toString(),
      "apiKey" : apiKey,
      "number" : "100"
    };

    test("should perform a GET request on a URL with with a list being the endpoint and with application/json header", () {
      setUpMockClientSuccess200();
      final uri = Uri.https('api.spoonacular.com', '/recipes/findByIngredients', data);
      dataSource.getRecipe(ingredients);

      verify(mockClient.get(uri, headers: {"Content-Type" : "application/json"}));
    });

    final List<RecipeModel> tRecipeList = [ const RecipeModel(
        title: "test title",
        imageUrl: "image url",
        ingredients: [IngredientsModel(
            name: "salt",
            amount: 1.0,
            unitOfMeasure: "cup",
            imageUrl: "test.url.com",
            original: 'cup')],
            id: 1)];

    test("should return a list of recipe model when the response code is 200 (success)", () async {
      setUpMockClientSuccess200();
      final result = await dataSource.getRecipe(ingredients);
      expect(result, equals(tRecipeList));
    });

    test("should throw a ServerException when the response code   is 404 or other", () async {
      setUpMockClientFailure404();
      final call = dataSource.getRecipe;
      expect(() => call(ingredients), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}