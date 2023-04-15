part of 'recipe_list_bloc.dart';

abstract class RecipeListState extends Equatable {
  const RecipeListState();
}

class Empty extends RecipeListState {
  @override
  List<Object> get props => [];
}

class Loading extends RecipeListState {
  @override
  List<Object?> get props => [];
}

class Loaded extends RecipeListState {
  @override
  List<Object?> get props => [];
}

