import 'package:flutter/material.dart';

import '../../../data/models/recipe_model.dart';
import '../../bloc/recipe/recipe_list_bloc.dart';
import '../states/recipe_list_view.dart';

class RecipeListCard extends StatelessWidget {
  const RecipeListCard({Key? key, required this.recipe, required this.recipeListBloc}) : super(key: key);
  final RecipeModel recipe;
  final RecipeListBloc recipeListBloc;

  @override
  Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Card(
          child: ListTile(
              title: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RecipeView(recipe: recipe,),
                    ),
                  );
                },
                child: Hero(
                  tag: recipe.id,
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
              ),
              subtitle: Text(recipe.title,
                textScaleFactor: 1.2,
                textAlign: TextAlign.center,)),
        ),
      );
    }
}
