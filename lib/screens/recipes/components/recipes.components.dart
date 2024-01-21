import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/screens/recipes/recipeDetails.screens.dart';
import 'package:flutter/material.dart';

class Recipes extends StatelessWidget {
  final String? id,title, image, meal_type;
  final double? rating;
  final int?  calerios, prep_time, serving;
  final int? viewType;
  
  const Recipes({
    super.key,
    required this.id,
    required this.title,
    required this.image,
    required this.meal_type,
    required this.rating,
    required this.calerios,
    required this.prep_time,
    required this.serving,
    this.viewType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(child: typeView(context));
  }

  typeView(
    BuildContext context,
  ) {
    switch (viewType) {
      case 0:
        return freshRecipes(context);
      case 1:
        return recommendedRecipes(context);
      case 2:
        return recipeDetails(context);
    }
  }

  Widget freshRecipes(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Container(
          alignment: Alignment.bottomLeft,
          margin:
              const EdgeInsets.only(top: 10, right: 30, bottom: 10, left: 10),
          width: 200,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: ColorsApp.lightGrey,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: ColorsApp.lightGrey,
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
              Transform.translate(
                  offset: const Offset(30, 0),
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                   RecipeDetailsScreen(recipeId: id)),
                        );
                        //    context.goNamed(AppRoutes.recipeDetailsScreen, queryParameters: {'recipeId':'$id'});
                      },
                      child: recipeImage(200, 150, context))),
              const SizedBox(
                height: 5,
              ),
              info(context, viewType!)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: favoriteIcon(),
        ),
      ],
    );
  }

  Widget recommendedRecipes(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (MediaQuery.of(context).size.width < 300) {
      width = 350;
    } else {
      width = MediaQuery.of(context).size.width - 50;
    }
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          alignment: Alignment.bottomLeft,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          width: width,
          decoration: BoxDecoration(
            color: ColorsApp.lightGrey,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: ColorsApp.lightGrey,
                blurRadius: 5,
              ),
            ],
          ),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                             RecipeDetailsScreen(recipeId: id)),
                  );
                  //  context.goNamed(AppRoutes.recipeDetailsScreen, queryParameters: {'recipeId':'$id'});
                },
                child: Align(
                    alignment: Alignment.center,
                    child: recipeImage(90, 50, context)),
              ),
              const SizedBox(
                width: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: info(context, viewType!),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: favoriteIcon(),
        )
      ],
    );
  }

  Widget recipeDetails(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 50,
          constraints: const BoxConstraints(minHeight: 250),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20, child: mealType(15)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      "$title",
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    child: SizedBox(
                      width: 20,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: favoriteIcon(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              colories(14),
              const SizedBox(
                height: 10,
              ),
              ratingStars(20),
              const SizedBox(
                height: 25,
              ),
              perpTime(20, 14),
              const SizedBox(
                height: 15,
              ),
              serve(20, 14),
            ],
          ),
        ),
        Transform.translate(
            offset: const Offset(80, 0), child: recipeImage(250, 180, context)),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }

  Widget info(BuildContext context, int viewType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mealType(12),
        InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                         RecipeDetailsScreen(recipeId: id)),
              );
              //  context.goNamed(AppRoutes.recipeDetailsScreen, queryParameters: {'recipeId':'$id'});
            },
            child: titleWidget(context, viewType)),
        const SizedBox(
          height: 5,
        ),
        viewType == 1
            ? Row(children: [
                ratingStars(14),
                const SizedBox(
                  width: 5,
                ),
                colories(10),
              ])
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ratingStars(14),
                  const SizedBox(
                    height: 5,
                  ),
                  colories(10),
                ],
              ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            perpTime(15, 12),
            const SizedBox(
              width: 10,
            ),
            serve(15, 12),
            const SizedBox(
              height: 10,
            ),
          ],
        )
      ],
    );
  }

  Widget mealType(double fontSize) {
    return Text(
      "$meal_type",
      style: TextStyle(fontSize: fontSize, color: ColorsApp.lightBlue),
    );
  }

  Widget titleWidget(BuildContext context, int viewType) {
    double width = MediaQuery.of(context).size.width;
    int maxLines;
    double minHeight;
    if (viewType == 1) {
      maxLines = 1;
      minHeight = 25;
      if (MediaQuery.of(context).size.width < 300) {
        width = 200;
      } else {
        width = MediaQuery.of(context).size.width - 200;
      }
    } else {
      width = 200;
      maxLines = 2;
      minHeight = 50;
    }
    return Container(
      width: width,
      constraints: BoxConstraints(minHeight: minHeight),
      child: Text(
        "$title",
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
            fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black),
      ),
    );
  }

  Widget ratingStars(double size) {
    return VxRating(
        value: rating!,
        onRatingUpdate: (value) {},
        normalColor: ColorsApp.textfieldGrey,
        selectionColor: ColorsApp.PKColor,
        size: size,
        stepInt: true,
        count: 5);
  }

  Widget colories(double fontSize) {
    return Text(
      "$calerios Colories",
      style: TextStyle(fontSize: fontSize, color: ColorsApp.PKColor),
    );
  }

  Widget serve(double iconSize, double fontSize) {
    return Row(
      children: [
        Icon(
          Icons.room_service_outlined,
          color: ColorsApp.borderLine,
          size: iconSize,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          "$serving serving",
          style: TextStyle(color: ColorsApp.borderLine, fontSize: fontSize),
        ),
      ],
    );
  }

  Widget perpTime(double iconSize, double fontSize) {
    return Row(
      children: [
        Icon(
          Icons.schedule,
          color: ColorsApp.borderLine,
          size: iconSize,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          "$prep_time mins",
          style: TextStyle(color: ColorsApp.borderLine, fontSize: fontSize),
        ),
      ],
    );
  }

  Widget recipeImage(double width, double height, BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Image.asset(image!, fit: BoxFit.fill),
    );
  }

  Widget favoriteIcon() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.favorite_outline,
          color: ColorsApp.borderLine,
        ),
      ),
    );
  }

  // recipeImage1(width, height) {
  //   return Container(
  //     height: height,
  //     width: width,
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(10.0),
  //         image: DecorationImage(
  //           image: NetworkImage(image!),
  //           fit: BoxFit.fill,
  //         )),
  //   );
  // }
}
