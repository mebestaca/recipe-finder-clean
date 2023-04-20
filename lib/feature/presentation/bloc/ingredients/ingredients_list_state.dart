part of 'ingredients_list_bloc.dart';

abstract class IngredientsListState extends Equatable {
  const IngredientsListState();
}

class EmptyIngredientsList extends IngredientsListState {
  @override
  List<Object> get props => [];
}

class NotEmptyIngredientsList extends IngredientsListState {
  @override
  List<Object?> get props => [];
}

