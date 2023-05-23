import 'package:flutter/material.dart';
import 'package:recipe_finder_clean/core/widgets/input_decoration.dart';
import 'package:recipe_finder_clean/feature/presentation/bloc/recipe/recipe_list_bloc.dart';

class RecipeListControl extends StatefulWidget {
  const RecipeListControl({Key? key, required this.recipeListBloc}) : super(key: key);
  final RecipeListBloc recipeListBloc;

  @override
  State<RecipeListControl> createState() => _RecipeListControlState();
}

class _RecipeListControlState extends State<RecipeListControl> {

  final controller = TextEditingController();
  late String ingredientString;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: controller,
              onChanged: (val) {
                ingredientString = val;
              },
              decoration: inputDecorationStyle.copyWith(
                labelText: "ingredient"
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () {
                  widget.recipeListBloc.add(OnAddIngredientsToList(ingredientString));
                  controller.clear();
              },
                child: const Text("Add"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () {
                widget.recipeListBloc.add(OnGetRecipeForRecipeList(
                    widget.recipeListBloc.getIngredientsList()
                ));
              },
                child: const Text("Search"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
