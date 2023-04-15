part of 'ingredients_bloc.dart';

abstract class IngredientsEvent extends Equatable {
  const IngredientsEvent();
}

class AddIngredientsToList extends IngredientsEvent {
  @override
  List<Object?> get props => [];
}

class RemoveIngredientsFromList extends IngredientsEvent {
  @override
  List<Object?> get props => [];
}