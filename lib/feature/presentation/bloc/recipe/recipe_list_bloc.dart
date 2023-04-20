import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/get_recipe.dart';

part 'recipe_list_event.dart';
part 'recipe_list_state.dart';

class RecipeListBloc extends Bloc<RecipeListEvent, RecipeListState> {

  final GetRecipe getRecipe;

  RecipeListBloc({required this.getRecipe}) : super(EmptyRecipeList()) {
    on<RecipeListEvent>((event, emit) async {
      if (event is GetRecipeForRecipeList) {
        final failureOrRecipeList = await getRecipe(Params(ingredients: event.ingredients ));
      }
    });
  }
}
