import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder_clean/feature/presentation/bloc/recipe/recipe_list_bloc.dart';

import '../../../injection_container.dart';
import '../../domain/entities/recipe.dart';

class RecipeListLoaded extends StatelessWidget {
  const RecipeListLoaded({Key? key, required this.recipeList}) : super(key: key);
  final List<Recipe> recipeList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Placeholder(),
    );
  }
}
