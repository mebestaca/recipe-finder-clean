import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder_clean/core/widgets/input_decoration.dart';
import 'package:recipe_finder_clean/feature/presentation/bloc/recipe/recipe_list_bloc.dart';

class RecipeListControl extends StatefulWidget {
  const RecipeListControl({Key? key}) : super(key: key);

  @override
  State<RecipeListControl> createState() => _RecipeListControlState();
}

class _RecipeListControlState extends State<RecipeListControl> {

  late String ingredientString;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
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
                  BlocProvider.of<RecipeListBloc>(context)
                      .add(AddIngredientsToList(ingredientString));
              },
                child: const Text("Add"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () {},
                child: const Text("Search"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
