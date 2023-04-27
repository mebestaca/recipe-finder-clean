import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../domain/entities/recipe.dart';
import '../../../domain/usecases/get_recipe.dart';

part 'recipe_list_event.dart';
part 'recipe_list_state.dart';

const String CACHE_FAILURE_MESSAGE = "Cache Failure";
const String SERVER_FAILURE_MESSAGE = "Server Failure";
class RecipeListBloc extends Bloc<RecipeListEvent, RecipeListState> {

  final GetRecipe getRecipe;

  RecipeListBloc({required this.getRecipe}) : super(EmptyRecipeList()) {
    on<RecipeListEvent>((event, emit) async {
      if (event is GetRecipeForRecipeList) {
        emit(LoadingRecipeList());
        final failureOrRecipeList = await getRecipe(Params(ingredients: event.ingredients ));
        emit(_eitherFailureOrLoadedState(failureOrRecipeList));
      }
    });
  }

  RecipeListState _eitherFailureOrLoadedState(
    Either<Failure, List<Recipe>> failureOrRecipeList
  ) {
    return failureOrRecipeList.fold(
      (failure) => ErrorRecipeList(message: _mapFailureMessage(failure)),
      (recipeList) => LoadedRecipeList(recipeList),
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
}
