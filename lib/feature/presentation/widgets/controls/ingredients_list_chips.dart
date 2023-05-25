import 'package:flutter/material.dart';

import '../../bloc/recipe/recipe_list_bloc.dart';

class IngredientsListChip extends StatelessWidget {
  const IngredientsListChip({Key? key, required this.recipeListBloc}) : super(key: key);
  final RecipeListBloc recipeListBloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<String>>(
        initialData: recipeListBloc.ingredientsList.ingredientsList.toList(),
        stream: recipeListBloc.getIngredientsListStream(),
        builder: (context, ingredientsList) {
          if (ingredientsList.hasData) {
            final ingredientsData = ingredientsList.data;
            if (ingredientsData!.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Wrap(
                  children: ingredientsData.map((e) {
                    return Chip(
                      label: Text(e),
                      deleteIcon: const Icon(Icons.close),
                      onDeleted: () {
                        recipeListBloc.add(OnRemoveIngredientsFromList(e));
                      },
                    );
                  }).toList(),
                ),
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