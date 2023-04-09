import 'package:equatable/equatable.dart';

class Recipe extends Equatable{
  final String title;
  final String imageUrl;

  const Recipe({
    required this.title,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [title, imageUrl];
}