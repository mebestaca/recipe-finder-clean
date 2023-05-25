import '../../domain/entities/ingredients.dart';

class IngredientsModel extends Ingredients{
  const IngredientsModel({
    required super.name,
    required super.amount,
    required super.unitOfMeasure,
    required super.imageUrl,
    required super.original
  });

  factory IngredientsModel.fromJson(Map<String, dynamic> json) {
    return IngredientsModel(
      name: json["name"] ?? "",
      amount: json["amount"]?.toDouble() ?? 0,
      unitOfMeasure: json["originalName"] ?? "",
      imageUrl: json["image"] ?? "",
      original: json["original"] ?? ""
    );
  }

  Map<String, dynamic> toJson() => {
    "name" : name,
    "amount" : amount,
    "originalName" : unitOfMeasure,
    "image" : imageUrl
  };

}