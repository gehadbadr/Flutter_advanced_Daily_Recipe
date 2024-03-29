class Recipe {
  String? docId, title, image, mealType, description;
  num? rating;
  num? calerios, prepTime, serving;
  bool? recommended,isFresh;
  List? ingredients,directions;
  List<String>? fanId;
  List<String>? viewerId;

  Recipe();

  Recipe.fromJson(Map<String, dynamic> data, [String? id]) {
    docId = id; 
    title = data['title'];
    image = data['image'];
    mealType = data['mealType'];
    description = data['description'];
    rating = data['rating'];
    calerios = data['calerios'];
    prepTime = data['prepTime'];
    serving = data['serving'];
    ingredients = data['ingredients'] != null
        ? List<String>.from(data['ingredients'].map((e) => e.toString()))
        : null;
    directions = data['directions'] != null
        ? List<String>.from(data['directions'].map((e) => e.toString()))
        : null;
    recommended = data['recommended'];
    isFresh = data['isFresh'];
    fanId = data['fans_ids'] != null
        ? List<String>.from(data['fans_ids'].map((e) => e.toString()))
        : null;
    viewerId = data['viewers_ids'] != null
        ? List<String>.from(data['viewers_ids'].map((e) => e.toString()))
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": docId,
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
