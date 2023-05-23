abstract class IngredientsListProvider{
  void addIngredient(String ingredient);
  void removeIngredient(String ingredient);
  List<String> getIngredientList();
}

class IngredientsList implements IngredientsListProvider{
  Set<String> ingredientsList = {};

  @override
  void addIngredient(String ingredient) {
    ingredientsList.add(ingredient);
  }

  @override
  void removeIngredient(String ingredient) {
    ingredientsList.remove(ingredient);
  }

  @override
  List<String> getIngredientList() {
    return ingredientsList.toList();
  }
}
