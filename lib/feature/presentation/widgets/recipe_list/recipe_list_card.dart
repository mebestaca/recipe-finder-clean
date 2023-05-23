import 'package:flutter/material.dart';

import '../../../domain/entities/recipe.dart';

class RecipeListCard extends StatelessWidget {
  const RecipeListCard({Key? key, required this.recipe}) : super(key: key);
  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
      return Card(
        child: ListTile(
            title: Image.network(
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
            subtitle: Center(child: Text(recipe.title))),
      );
    }
}
