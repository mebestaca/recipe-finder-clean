import 'package:flutter/material.dart';
import 'package:recipe_finder_clean/feature/presentation/widgets/recipe_list/ingredients_list_card.dart';

import '../../../data/models/recipe_model.dart';
import '../theme/background.dart';

class RecipeView extends StatelessWidget {
  const RecipeView({Key? key, required this.recipe,}) : super(key: key);
  final RecipeModel recipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title,),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          const Background(),
          SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                        child: Center(
                            child: Text(
                                recipe.title,
                                textScaleFactor: 2.5,
                            )
                        )
                    )
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Hero(
                          tag: recipe.id,
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
                                  return IngredientsListCard(
                                      ingredientsModel: recipe.ingredients[index]
                                  );
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
        ],
      ),
    );
  }
}
