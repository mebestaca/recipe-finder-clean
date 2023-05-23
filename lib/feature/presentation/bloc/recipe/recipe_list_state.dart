part of 'recipe_list_bloc.dart';

abstract class RecipeListState extends Equatable {
  const RecipeListState();
}

class EmptyRecipeListState extends RecipeListState {
  @override
  List<Object> get props => [];
}

class LoadingRecipeListState extends RecipeListState {
  @override
  List<Object?> get props => [];
}

class LoadedRecipeListState extends RecipeListState {
  final List<Recipe> recipeList;
  const LoadedRecipeListState(this.recipeList);

  @override
  List<Object?> get props => [recipeList];
}

class ErrorRecipeListState extends RecipeListState {
  final String message;
  const ErrorRecipeListState({required this.message});

  @override
  List<Object?> get props => [message];
}

class RecipeViewState extends RecipeListState {
  final Recipe recipe;
  const RecipeViewState(this.recipe);

  @override
  List<Object?> get props => [recipe];
}

