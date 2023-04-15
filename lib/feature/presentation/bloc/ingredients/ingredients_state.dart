part of 'ingredients_bloc.dart';

abstract class IngredientsState extends Equatable {
  const IngredientsState();
}

class Empty extends IngredientsState {
  @override
  List<Object> get props => [];
}

class HasContent extends IngredientsState {
  @override
  List<Object?> get props => [];

}
