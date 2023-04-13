import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:recipe_finder_clean/feature/data/datasources/recipe_remote_data_source.dart';
import 'package:recipe_finder_clean/keys/keys.dart';
import 'package:http/http.dart' as http;

import '../../../fixtures/fixture_reader.dart';
import 'recipe_remote_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
void main() {
  late RecipeRemoteDataSourceImpl dataSource;
  late MockClient mockClient;

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
      when(mockClient.get(any, headers: anyNamed("headers")))
        .thenAnswer((_) async => Response(fixture("recipe.json"), 200));
      final uri = Uri.http('api.spoonacular.com', '/recipes/findByIngredients', data);
      dataSource.getRecipe(ingredients);

      verify(mockClient.get(uri, headers: {"Content-Type" : "application/json"}));
    });
  });
}