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