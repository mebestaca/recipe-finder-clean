import 'package:flutter/material.dart';

import '../../../data/models/recipe_model.dart';
import '../../bloc/recipe/recipe_list_bloc.dart';

class RecipeListCard extends StatelessWidget {
  const RecipeListCard({Key? key, required this.recipe, required this.recipeListBloc}) : super(key: key);
  final RecipeModel recipe;
  final RecipeListBloc recipeListBloc;

  @override
  Widget build(BuildContext context) {
      return Card(
        child: ListTile(
            title: GestureDetector(
              onTap: () {
                recipeListBloc.add(OnTapRecipe(recipe));
              },
              child: Image.network(
                recipe.imageUrl,
                fit: BoxFit.fill,
                loadingBuilder: ( _, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
            subtitle: Text(recipe.title,
              textScaleFactor: 1.2,
              textAlign: TextAlign.center,)),
      );
    }
}
