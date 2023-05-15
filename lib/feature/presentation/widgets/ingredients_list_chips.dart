import 'package:flutter/material.dart';

import '../bloc/recipe/recipe_list_bloc.dart';

class IngredientsListChip extends StatelessWidget {
  const IngredientsListChip({Key? key, required this.recipeListBloc}) : super(key: key);
  final RecipeListBloc recipeListBloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<String>>(
        stream: recipeListBloc.getIngredientsList(),
        builder: (context, ingredientsList) {
          if (ingredientsList.hasData) {
            final ingredientsData = ingredientsList.data;
            if (ingredientsData!.isNotEmpty) {
              return Wrap(
                children: ingredientsData.map((e) {
                  return Chip(
                    label: Text(e),
                    deleteIcon: const Icon(Icons.close),
                    onDeleted: () {
                    },
                  );
                }).toList(),
              );
            }
            return Container();
          }
          else{
            return Container();
          }
        }
    );
  }
}
