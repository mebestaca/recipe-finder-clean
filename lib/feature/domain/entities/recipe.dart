import 'package:equatable/equatable.dart';

class Recipe extends Equatable{
  final String title;
  final String imageUrl;
  final int id;

  const Recipe({
    required this.title,
    required this.imageUrl,
    required this.id
  });

  @override
  List<Object?> get props => [title, imageUrl];
}