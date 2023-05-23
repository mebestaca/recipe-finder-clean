import 'package:flutter/material.dart';

class RecipeListError extends StatelessWidget {
  const RecipeListError({
    Key? key,
    required this.message
  }) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}
