import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder_clean/feature/presentation/bloc/recipe/recipe_list_bloc.dart';
import 'package:recipe_finder_clean/feature/presentation/widgets/controls/recipe_list_control.dart';
import 'package:recipe_finder_clean/feature/presentation/widgets/states/recipe_list_error.dart';
import 'package:recipe_finder_clean/feature/presentation/widgets/states/recipe_list_loaded.dart';

import '../../../injection_container.dart';
import '../widgets/controls/ingredients_list_chips.dart';
import '../widgets/states/recipe_list_loading.dart';
import '../widgets/states/recipe_list_view.dart';
import '../widgets/theme/background.dart';

class RecipeListMainPage extends StatefulWidget {
  const RecipeListMainPage({Key? key}) : super(key: key);

  @override
  State<RecipeListMainPage> createState() => _RecipeListMainPageState();
}

class _RecipeListMainPageState extends State<RecipeListMainPage> {

  final RecipeListBloc recipeListBloc = sl<RecipeListBloc>();

  @override
  Widget build(BuildContext context) {

    return BlocProvider<RecipeListBloc>(
      lazy: false,
      create: (_) => recipeListBloc,
      child: BlocBuilder<RecipeListBloc, RecipeListState>(
        builder: (context, state) {
          if (state is LoadedRecipeListState) {
            return RecipeListLoaded(
                recipeList: state.recipeList,
                recipeListBloc: recipeListBloc,
            );
          }
          else if (state is LoadingRecipeListState) {
            return const RecipeListLoading();
          }
          else if (state is ErrorRecipeListState) {
            return RecipeListError(message: state.message);
          }
          else if (state is RecipeViewState) {
            return RecipeView(recipe: state.recipe,);
          }
          else {
            return Scaffold(
              body: SafeArea(
                child: Stack(
                  children: [
                    const Background(),
                    ClipPath(
                      clipper: CustomClipPath(),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 2,
                        color: Colors.green[900],
                      ),
                    ),
                    Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            RecipeListControl(recipeListBloc: recipeListBloc),
                            IngredientsListChip(recipeListBloc: recipeListBloc),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    final path = Path();

    path.lineTo(0, h - 100);
    path.quadraticBezierTo(
      w * .5,
      h,
      w,
      h - 100
    );
    path.lineTo(w, 0);
    path.close();

    return path;

  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
  
}

