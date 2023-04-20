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
  @override
  List<Object?> get props => [];
}

