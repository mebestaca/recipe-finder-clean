import 'package:equatable/equatable.dart';

import 'ingredients.dart';

class Recipe extends Equatable{
  final String title;
  final String imageUrl;
  final List<Ingredients> ingredients;

  const Recipe({
    required this.title,
    required this.imageUrl,
    required this.ingredients,
  });

  @override
  List<Object?> get props => [ingredients, title, imageUrl];
}