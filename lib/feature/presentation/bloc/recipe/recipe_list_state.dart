part of 'recipe_list_bloc.dart';

abstract class RecipeListState extends Equatable {
  const RecipeListState();
}

class EmptyRecipeList extends RecipeListState {
  @override
  List<Object> get props => [];
}

class LoadingRecipeList extends RecipeListState {
  @override
  List<Object?> get props => [];
}

class LoadedRecipeList extends RecipeListState {
  final List<Recipe> recipeList;
  const LoadedRecipeList(this.recipeList);

  @override
  List<Object?> get props => [recipeList];
}

class ErrorRecipeList extends RecipeListState {
  final String message;
  const ErrorRecipeList({required this.message});

  @override
  List<Object?> get props => [message];
}

