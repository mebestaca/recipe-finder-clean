import 'package:flutter/material.dart';
import 'package:recipe_finder_clean/feature/data/models/ingredients_model.dart';

class IngredientsListCard extends StatelessWidget {
  const IngredientsListCard({Key? key, required this.ingredientsModel}) : super(key: key);
  final IngredientsModel ingredientsModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: 100,
        height: 200,
        child: Image.network(
          ingredientsModel.imageUrl,
          fit: BoxFit.scaleDown,
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
          },
        ),
      ),
      title: Text(ingredientsModel.original,
        textScaleFactor: 1.2,
      ),
      subtitle: Text("${ingredientsModel.name} ${ingredientsModel.amount} ${ingredientsModel.unitOfMeasure}"),
    );
  }
}
