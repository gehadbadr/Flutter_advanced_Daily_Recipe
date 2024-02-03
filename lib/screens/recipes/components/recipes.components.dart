import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/models/recipes.models.dart';
import 'package:daily_recipe/screens/recipes/recipeDetails.screens.dart';
import 'package:flutter/material.dart';

class Recipes extends StatelessWidget {
/*  final String? id, title, image, mealType;
  final num? rating;
  final num? calerios, prepTime, serving;*/
  final Recipe recipeDetails;
  final int? viewType;
  final Function()? onPressAction;
  final bool? isFavorite;

  const Recipes({
    super.key,
    required this.recipeDetails,
    /*  required this.id,
    required this.title,
    required this.image,
    required this.mealType,
    required this.rating,
    required this.calerios,
    required this.prepTime,
    required this.serving,*/
    required this.isFavorite,
    this.viewType,
    this.onPressAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(child: typeView(context));
  }

  typeView(
    BuildContext context,
  ) {
    switch (viewType) {
      case 0://display recipes in vertical card.
        return freshRecipes(context);
      case 1://display recipes in horizontal card.
        return recommendedRecipes(context);
      case 2://display all Details of recipe in page.
        return recipeDetailsWidget(context);
      case 3://display recipes in horizontal card without favorite icon in RecentlyViewedScreen.
        return recommendedRecipes(context); 
      case 4://display recipes in vertical card change img size.
        return freshRecipes(context);

    }
  }
//display recipes in horizontal order
  Widget freshRecipes(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      margin: const EdgeInsets.only(top: 10, right: 30, bottom: 10, left: 10),
      width: viewType == 0 ? 200:200,
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              favoriteIcon(),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecipeDetailsScreen(
                                recipeDetails: recipeDetails)),
                      );
                    },
                    child:viewType == 0 ? recipeImage(130, 130, context):recipeImage(90, 90, context)),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          info(context, viewType!)
        ],
      ),
    );
  }
//display recipes in vertical order
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
                            RecipeDetailsScreen(recipeDetails: recipeDetails)),
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
          padding: const EdgeInsets.all(16.0),
          child:viewType== 3?closeIcon(): favoriteIcon(),
        )
      ],
    );
  }
//display a recipe.
  Widget recipeDetailsWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      constraints: const BoxConstraints(minHeight: 250),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20, child: mealTypeWidget(15)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  recipeDetails.title!,
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
                    child:favoriteIcon(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
              const SizedBox(
                width: 5,
              ),
              recipeImage(220, 170, context),
              const SizedBox(
                height: 5,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget info(BuildContext context, int viewType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mealTypeWidget(12),
        InkWell(
            onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        RecipeDetailsScreen(recipeDetails: recipeDetails)),
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
         MediaQuery.of(context).size.width < 450 && viewType == 4?Column(
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
        ):Row(
          children: [
            perpTime(15, 12),
            const SizedBox(
              width: 10,
            ),
            serve(15, 12),
            const SizedBox(
              height: 10,
            ),
      ],)]
    );
  }

  Widget mealTypeWidget(double fontSize) {
    return Text(
      recipeDetails.mealType!,
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
        recipeDetails.title!,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
            fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black),
      ),
    );
  }

  Widget ratingStars(double size) {
    return VxRating(
        value: recipeDetails.rating!,
        onRatingUpdate: (value) {},
        normalColor: ColorsApp.textfieldGrey,
        selectionColor: ColorsApp.PKColor,
        size: size,
        stepInt: true,
        count: 5);
  }

  Widget colories(double fontSize) {
    return Text(
      "${recipeDetails.calerios} ${TextApp.calories}",
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
          "${recipeDetails.serving} ${TextApp.serving}",
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
          "${recipeDetails.prepTime} ${TextApp.mins}",
          style: TextStyle(color: ColorsApp.borderLine, fontSize: fontSize),
        ),
      ],
    );
  }


  Widget favoriteIcon() {
    Color favoriteColor;
    IconData favoriteIcon;
    if (isFavorite!) {
      favoriteColor = ColorsApp.PKColor;
      favoriteIcon = Icons.favorite;
    } else {
      favoriteColor = ColorsApp.borderLine;
      favoriteIcon = Icons.favorite_outline;
    }
    return IconButton(
        onPressed: onPressAction,
        icon: Icon(
          favoriteIcon,
          color: favoriteColor,
        ));
  }

  Widget closeIcon() {
    return IconButton(
        onPressed: onPressAction,
        icon: const Icon(
          Icons.close,
          color: ColorsApp.PKColor,
        ));
  }

  recipeImage(width, height, BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: CachedNetworkImage(
          imageUrl: recipeDetails.image!,
          placeholder: (context, url) => Text(recipeDetails.title!),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
