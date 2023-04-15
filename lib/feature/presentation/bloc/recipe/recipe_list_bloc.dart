import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'recipe_list_event.dart';
part 'recipe_list_state.dart';

class RecipeListBloc extends Bloc<RecipeListEvent, RecipeListState> {
  RecipeListBloc() : super(Empty()) {
    on<RecipeListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
