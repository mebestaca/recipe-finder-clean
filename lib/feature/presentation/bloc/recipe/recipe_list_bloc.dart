import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../data/models/recipe_model.dart';
import '../../../domain/usecases/get_recipe.dart';
import '../../utils/ingredients_list_util.dart';

part 'recipe_list_event.dart';
part 'recipe_list_state.dart';

const String CACHE_FAILURE_MESSAGE = "Cache Failure";
const String SERVER_FAILURE_MESSAGE = "Server Failure";
class RecipeListBloc extends Bloc<RecipeListEvent, RecipeListState> {

  final GetRecipe getRecipe;
  final IngredientsList ingredientsList;

  final StreamController<List<String>> _ingredientsListController = StreamController<List<String>>.broadcast();
  Stream<List<String>> getIngredientsListStream() => _ingredientsListController.stream;
  List<String> getIngredientsList() => ingredientsList.ingredientsList.toList();

  RecipeListBloc({required this.ingredientsList, required this.getRecipe}) : super(EmptyRecipeListState()) {
    on<RecipeListEvent>((event, emit) async {
      if (event is OnReturnToMenu) {
        emit(EmptyRecipeListState());
      }
      else if (event is OnGetRecipeForRecipeList) {
        emit(LoadingRecipeListState());
        final failureOrRecipeList = await getRecipe(Params(ingredients: event.ingredients ));
        emit(_eitherFailureOrLoadedState(failureOrRecipeList));
      }
      else if (event is OnAddIngredientsToList) {
        ingredientsList.addIngredient(event.ingredient);
        _updateIngredientsList();
      }
      else if (event is OnRemoveIngredientsFromList) {
        ingredientsList.removeIngredient(event.ingredient);
        _updateIngredientsList();
      }
    });
  }

  RecipeListState _eitherFailureOrLoadedState(
    Either<Failure, List<RecipeModel>> failureOrRecipeList
  ) {
    return failureOrRecipeList.fold(
      (failure) => ErrorRecipeListState(message: _mapFailureMessage(failure)),
      (recipeList) => LoadedRecipeListState(recipeList)
    );
  }

  String _mapFailureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return "Unexpected Failure";
    }
  }

  void _updateIngredientsList() {
    _ingredientsListController.sink.add(ingredientsList.getIngredientList());
  }

  @override
  Future<void> close() {
    _ingredientsListController.close();
    return super.close();
  }
}
