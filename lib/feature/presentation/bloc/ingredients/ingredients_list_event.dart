part of 'ingredients_list_bloc.dart';

abstract class IngredientsListEvent extends Equatable {
  const IngredientsListEvent();
}

class AddIngredientsToList extends IngredientsListEvent {
  @override
  List<Object?> get props => [];
}

class RemoveIngredientsFromList extends IngredientsListEvent {
  @override
  List<Object?> get props => [];
}
