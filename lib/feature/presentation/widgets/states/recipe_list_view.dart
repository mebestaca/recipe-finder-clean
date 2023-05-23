import 'package:flutter/material.dart';
import 'package:recipe_finder_clean/feature/presentation/bloc/recipe/recipe_list_bloc.dart';

import '../../../domain/entities/recipe.dart';

class RecipeView extends StatelessWidget {
  const RecipeView({Key? key, required this.recipe, required this.recipeListBloc}) : super(key: key);
  final Recipe recipe;
  final RecipeListBloc recipeListBloc;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
