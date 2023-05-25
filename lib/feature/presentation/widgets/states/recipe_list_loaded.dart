import 'package:flutter/material.dart';
import 'package:recipe_finder_clean/feature/presentation/bloc/recipe/recipe_list_bloc.dart';
import 'package:recipe_finder_clean/feature/presentation/widgets/recipe_list/recipe_list_card.dart';

import '../../../data/models/recipe_model.dart';
import '../theme/background.dart';

class RecipeListLoaded extends StatelessWidget {
  const RecipeListLoaded({Key? key, required this.recipeList, required this.recipeListBloc}) : super(key: key);
  final RecipeListBloc recipeListBloc;
  final List<RecipeModel> recipeList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipes"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            recipeListBloc.add(OnReturnToMenu());
          },
        ),
      ),
      body: Stack(
        children: [
          const Background(),
          ListView.builder(
              itemCount: recipeList.length,
              itemBuilder: (context, index) {
                return RecipeListCard(
                  recipe: recipeList[index],
                  recipeListBloc: recipeListBloc,
                );
              }
          ),
        ],
      ),
    );
  }
}
