import 'dart:convert';

List<RecipeModel> recipeModelFromJson(String str) => List<RecipeModel>.from(
    json.decode(str).map((x) => RecipeModel.fromJson(x)));

String recipeModelToJson(List<RecipeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<RecipeModel> dynamictoListRecipeModel(List<dynamic> dynamicList) {
  return List<RecipeModel>.from(dynamicList.map((x) => RecipeModel.fromJson(x)));
}

class RecipeModel {
  int id;
  String name;
  String type;
  String image;
  String imageName;
  String imageType;
  bool isLiked;
  bool isDeleteable;
  String recipe;
  String ingredients;
  String createdBy;

  RecipeModel({
    required this.id,
    required this.name,
    required this.type,
    required this.image,
    required this.imageName,
    required this.imageType,
    required this.isLiked,
    required this.isDeleteable,
    required this.recipe,
    required this.ingredients,
    required this.createdBy,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        image: json["image"],
        imageName: json["imageName"],
        imageType: json["imageType"],
        isLiked: json["isLiked"],
        isDeleteable: json["isDeleteable"],
        recipe: json["recipe"],
        ingredients: json["ingredients"],
        createdBy: json["createdBy"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "image": image,
        "imageName": imageName,
        "imageType": imageType,
        "isLiked": isLiked,
        "isDeleteable": isDeleteable,
        "recipe": recipe,
        "ingredients": ingredients,
        "createdBy": createdBy,
      };
}
