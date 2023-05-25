import 'package:equatable/equatable.dart';

class Ingredients extends Equatable{
  final String name;
  final String unitOfMeasure;
  final double amount;
  final String imageUrl;
  final String original;

  const Ingredients({
    required this.name,
    required this.amount,
    required this.unitOfMeasure,
    required this.imageUrl,
    required this.original,
  });

  @override
  List<Object?> get props => [name, unitOfMeasure, amount, imageUrl, original];
}