import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder_clean/feature/presentation/bloc/recipe/recipe_list_bloc.dart';
import 'package:recipe_finder_clean/feature/presentation/widgets/recipe_list_control.dart';
import 'package:recipe_finder_clean/feature/presentation/widgets/recipe_list_error.dart';
import 'package:recipe_finder_clean/feature/presentation/widgets/recipe_list_loaded.dart';
import 'package:recipe_finder_clean/feature/presentation/widgets/recipe_list_loading.dart';

import '../../../injection_container.dart';
import '../widgets/ingredients_list_chips.dart';

class RecipeListMainPage extends StatefulWidget {
  const RecipeListMainPage({Key? key}) : super(key: key);

  @override
  State<RecipeListMainPage> createState() => _RecipeListMainPageState();
}

class _RecipeListMainPageState extends State<RecipeListMainPage> {

  @override
  Widget build(BuildContext context) {
    final RecipeListBloc recipeListBloc = sl<RecipeListBloc>();
    return BlocProvider<RecipeListBloc>(
      create: (_) => recipeListBloc,
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const RecipeListControl(),
              IngredientsListChip(recipeListBloc: recipeListBloc,),
              BlocBuilder<RecipeListBloc, RecipeListState>(
                  builder: (context, state) {
                    if (state is EmptyRecipeListState) {
                      return Container();
                    }
                    else if (state is LoadingRecipeListState) {
                      return const RecipeListLoading();
                    }
                    else if (state is LoadedRecipeListState) {
                      return const RecipeListLoaded();
                    }
                    else if (state is ErrorRecipeListState) {
                      return RecipeListError(message: state.message);
                    }
                    else {
                      return Container();
                    }
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}

