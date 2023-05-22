import 'package:flutter/material.dart';
import 'package:recipe_finder_clean/feature/presentation/bloc/recipe/recipe_list_bloc.dart';
import '../../domain/entities/recipe.dart';

class RecipeListLoaded extends StatelessWidget {
  const RecipeListLoaded({Key? key, required this.recipeList, required this.recipeListBloc}) : super(key: key);
  final RecipeListBloc recipeListBloc;
  final List<Recipe> recipeList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            recipeListBloc.add(ReturnToMenu());
          },
        ),

      ),
      body: ListView.builder(
          itemCount: recipeList.length,
          itemBuilder: (context, index) {
              return Card(
                child: Text(recipeList[index].title),
              );
          }
      ),
    );
  }
}
