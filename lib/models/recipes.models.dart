class Recipe {
  String? id, title, image, mealType, description;
  double? rating;
  int? calerios, prepTime, serving;
  bool? recommended;
  List? ingredients,directions;
  Recipe();

  Recipe.fromJson(Map<String, dynamic> data, [String? docId]) {
    id = data['id'];
    title = data['title'];
    image = data['image'];
    mealType = data['mealType'];
    description = data['description'];
    rating = data['rating'];
    calerios = data['calerios'];
    prepTime = data['prepTime'];
    serving = data['serving'];
    ingredients = data['ingredients'];
    directions = data['directions'];
    recommended = data['recommended'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "meal_type": mealType,
      "description": description,
      "rating": rating,
      "calerios": calerios,
      "prep_time": prepTime,
      "serving": serving,
      "recommended": recommended
    };
  }
}


// // class Ingredients {
//   Ingredients({
//     required this.ingredients,
//   });

//   String name;
//   String ingredients;

//   factory Ingredients.fromJson(Map<String, dynamic> json) => Ingredients(
//         name: json["name"],
//         ingredients: json["ingredients"],
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "ingredients": ingredients,
    
//       };
// }