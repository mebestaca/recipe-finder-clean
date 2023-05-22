part of 'recipe_list_bloc.dart';

abstract class RecipeListEvent extends Equatable {
  const RecipeListEvent();
}

class GetRecipeForRecipeList extends RecipeListEvent {
  final List<String> ingredients;

  const GetRecipeForRecipeList(this.ingredients);

  @override
  List<Object?> get props => [ingredients];
}

class ReturnToMenu extends RecipeListEvent{

  @override
  List<Object?> get props => [];
}

class AddIngredientsToList extends RecipeListEvent {
  final String ingredient;
  const AddIngredientsToList(this.ingredient);

  @override
  List<Object?> get props => [ingredient];
}

class RemoveIngredientsFromList extends RecipeListEvent {
  final String ingredient;
  const RemoveIngredientsFromList(this.ingredient);

  @override
  List<Object?> get props => [ingredient];
}
