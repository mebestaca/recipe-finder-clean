import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'ingredients_list_event.dart';
part 'ingredients_list_state.dart';

class IngredientsListBloc extends Bloc<IngredientsListEvent, IngredientsListState> {
  IngredientsListBloc() : super(EmptyIngredientsList()) {
    on<IngredientsListEvent>((event, emit) {

    });
  }
}
