import 'package:daily_recipe/consts/consts.dart';
import 'package:flutter/material.dart';

class FreshRecipes extends StatelessWidget {
  String? title, image, meal_type;
  double? rating;
  int? id, calerios, prep_time, serving;
  bool? recommended;
  FreshRecipes({
    super.key,
    required this.id,
    required this.title,
    required this.image,
    required this.meal_type,
    required this.rating,
    required this.calerios,
    required this.prep_time,
    required this.serving,
    this.recommended,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: recommended! ? vertical(context) : horizontal(context));
  }

  horizontal(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Container(
          alignment: Alignment.bottomLeft,
          margin: EdgeInsets.all(10),
          width: context.screenWidth / 2,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: lightGrey,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: lightGrey,
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              Align(alignment: Alignment.centerRight, child: recipeImage(120, 120)),
              const SizedBox(
                height: 5,
              ),
              info(recommended!)
            ],
          ),
        ),
        Padding(padding: EdgeInsets.all(8.0), child:favoriteIcon(),)    
      ],
    );
  }

  vertical(BuildContext context) {
    return Stack(
    alignment: Alignment.topRight,
      children: [
        Container(
          alignment: Alignment.bottomLeft,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: lightGrey,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: lightGrey,
                blurRadius: 5,
              ),
            ],
          ),
          child: Row(
            children: [
              Align(alignment: Alignment.center, child: recipeImage(80, 80)),
              const SizedBox(
                width: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: info(recommended!),
              ),
              ],
          ),
        ),
       Padding(padding: EdgeInsets.all(8.0), child:favoriteIcon(),)    

      ],
    );
  }

  info(bool recommendedvalue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${meal_type}",
          style: TextStyle(fontSize: 12, color: lightBlue),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          "${title}",
          style:
              TextStyle(fontSize: 20, fontFamily: regular, color: Colors.black),
        ),
        const SizedBox(
          height: 5,
        ),
        !recommendedvalue
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VxRating(
                      value: rating!,
                      onRatingUpdate: (value) {},
                      normalColor: textfieldGrey,
                      selectionColor: PKColor,
                      size: 10,
                      stepInt: true,
                      count: 5),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${calerios} Colories",
                    style: TextStyle(fontSize: 15, color: PKColor),
                  ),
                ],
              )
            : Row(children: [
                VxRating(
                    value: rating!,
                    onRatingUpdate: (value) {},
                    normalColor: textfieldGrey,
                    selectionColor: PKColor,
                    size: 10,
                    stepInt: true,
                    count: 5),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "${calerios} Colories",
                  style: TextStyle(fontSize: 12, color: PKColor),
                ),
              ]),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Icon(
              Icons.schedule,
              size: 15,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "${prep_time} prep time",
              style: TextStyle(color: fontGrey, fontSize: 12),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.room_service_outlined,
              size: 15,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "${serving} serving",
              style: TextStyle(color: fontGrey, fontSize: 12),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        )
      ],
    );
  }

  recipeImage(width, height) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: NetworkImage(image!),
            fit: BoxFit.fill,
          )),
    );
  }

  favoriteIcon() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.favorite_outline,
        color: PKColor,
      ),
    );
  }
}
