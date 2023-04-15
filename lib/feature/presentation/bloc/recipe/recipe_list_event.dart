part of 'recipe_list_bloc.dart';

abstract class RecipeListEvent extends Equatable {
  const RecipeListEvent();
}

class GetRecipeForRecipeList extends RecipeListEvent {
  @override
  List<Object?> get props => [];
}
