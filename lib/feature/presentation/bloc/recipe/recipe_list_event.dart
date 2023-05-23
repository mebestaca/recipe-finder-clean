part of 'recipe_list_bloc.dart';

abstract class RecipeListEvent extends Equatable {
  const RecipeListEvent();
}

class OnGetRecipeForRecipeList extends RecipeListEvent {
  final List<String> ingredients;

  const OnGetRecipeForRecipeList(this.ingredients);

  @override
  List<Object?> get props => [ingredients];
}

class OnReturnToMenu extends RecipeListEvent{

  @override
  List<Object?> get props => [];
}

class OnAddIngredientsToList extends RecipeListEvent {
  final String ingredient;
  const OnAddIngredientsToList(this.ingredient);

  @override
  List<Object?> get props => [ingredient];
}

class OnRemoveIngredientsFromList extends RecipeListEvent {
  final String ingredient;
  const OnRemoveIngredientsFromList(this.ingredient);

  @override
  List<Object?> get props => [ingredient];
}

class OnTapRecipe extends RecipeListEvent {

  final RecipeModel recipe;
  const OnTapRecipe(this.recipe);

  @override
  List<Object?> get props => [recipe];
}