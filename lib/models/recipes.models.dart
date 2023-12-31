class Recipe {
  String? title,image, meal_type,description;
  double? rating;
  int? id,calerios, prep_time,serving;
  bool? recommended;

  Recipe();

  Recipe.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    title = data['title'];
    image = data['image'];
    meal_type = data['meal_type'];
    description = data['description'];
    rating = data['rating'];
    calerios = data['calerios'];
    prep_time = data['prep_time'];
    serving = data['serving'];
    recommended = data['recommended'];
  }

  Map<String, dynamic> toJson() {
    return {"id": id,"title": title, "meal_type": meal_type,"description": description, "rating": rating,"calerios": calerios, "prep_time": prep_time, "serving": serving,"recommended":recommended} ;
  }
}
