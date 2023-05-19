import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder_clean/feature/presentation/bloc/recipe/recipe_list_bloc.dart';

import '../../../injection_container.dart';
import '../../domain/entities/recipe.dart';

class RecipeListLoaded extends StatelessWidget {
  const RecipeListLoaded({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    List<Recipe> recipeList = ModalRoute.of(context)?.settings.arguments as List<Recipe>;

    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemBuilder: (context, index) {
            return Container();
          }
      ),
    );
  }
}
