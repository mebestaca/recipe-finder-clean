import 'package:flutter/material.dart';

import '../theme/background.dart';

class RecipeListLoading extends StatelessWidget {
  const RecipeListLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Stack(
        children: [
          Background(),
          Center(
            child: SizedBox(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
