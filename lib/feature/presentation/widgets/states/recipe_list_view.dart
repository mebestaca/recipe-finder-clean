import 'package:flutter/material.dart';
import 'package:recipe_finder_clean/feature/presentation/bloc/recipe/recipe_list_bloc.dart';

import '../../../data/models/recipe_model.dart';

class RecipeView extends StatelessWidget {
  const RecipeView({Key? key, required this.recipe, required this.recipeListBloc}) : super(key: key);
  final RecipeModel recipe;
  final RecipeListBloc recipeListBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {

          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Card(
                    child: Center(
                        child: Text(recipe.title)
                    )
                )
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.network(
                      recipe.imageUrl,
                      fit: BoxFit.fill,
                      loadingBuilder: (_, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      }
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: recipe.ingredients.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Card(
                    child: ExpansionTile(
                      title: const Text("Used Ingredients"),
                      children: [
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: recipe.ingredients.length,
                            itemBuilder: (context, index) {
                              return const Placeholder();
                              // return SharedListTile(recipe: recipe.usedIngredients[index]);
                            }
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
