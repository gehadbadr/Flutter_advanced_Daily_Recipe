import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/models/recipes.models.dart';
import 'package:daily_recipe/providers/lang.providers.dart';
import 'package:daily_recipe/screens/recipes/recipeDetails.screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Recipes extends StatefulWidget {

  final Recipe recipeDetails;
  final int? viewType;
  final Function()? onPressAction;
  final bool? isFavorite;

  const Recipes({
    super.key,
    required this.recipeDetails,
    required this.isFavorite,
    this.viewType,
    this.onPressAction,
  });

  @override
  State<Recipes> createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: typeView(context));
  }

  typeView(
    BuildContext context,
  ) {
    switch (widget.viewType) {
      case 0: //display recipes in vertical card.
        return freshRecipes(context);
      case 1: //display recipes in horizontal card.
        return recommendedRecipes(context);
      case 2: //display all Details of recipe in page.
        return recipeDetailsWidget(context);
      case 3: //display recipes in horizontal card with close in=con instead of favorite icon in RecentlyViewedScreen.
        return recommendedRecipes(context);
      case 4: //display recipes in vertical card change img size.
        return freshRecipes(context);
      case 5: //display recipes in horizontal card without favorite icon in FilteredRecipesScreen.
        return recommendedRecipes(context);
    
    }
  }

//display recipes in horizontal order
  Widget freshRecipes(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      margin: const EdgeInsets.only(top: 10, right: 30, bottom: 10, left: 10),
      width: widget.viewType == 0 ? 200 : 300,
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
       //isArabic?
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              favoriteIcon(),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecipeDetailsScreen(
                                recipeDetails: widget.recipeDetails)),
                      );
                    },
                    child: widget.viewType == 0
                        ? recipeImage(130, 130, context)
                        : recipeImage(context.screenWidth / 6, 90, context)),
              ),
            ],
          )
          //  :  Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children:[
          //     Padding(
          //       padding: const EdgeInsets.only(top: 8.0),
          //       child: InkWell(
          //           onTap: () {
          //             Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                   builder: (context) => RecipeDetailsScreen(
          //                       recipeDetails: widget.recipeDetails)),
          //             );
          //           },
          //           child: widget.viewType == 0
          //               ? recipeImage(130, 130, context)
          //               : recipeImage(context.screenWidth / 6, 90, context)),
          //     ),
          //     favoriteIcon(),

          //   ],
          // ),
          ,const SizedBox(
            height: 5,
          ),
          info(context, widget.viewType!)
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
      alignment: !Provider.of<LangController>(context, listen: false).isArabic()?Alignment.topRight:Alignment.topLeft,
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
                            RecipeDetailsScreen(recipeDetails: widget.recipeDetails)),
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
                child: info(context, widget.viewType!),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: widget.viewType == 3
              ? closeIcon()
              : widget.viewType == 5
                  ? Container()
                  : favoriteIcon(),
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
                  widget.recipeDetails.title!,
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                child: SizedBox(
                  width: 30,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: favoriteIcon(),
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
                  colories(14,context),
                  const SizedBox(
                    height: 10,
                  ),
                  ratingStars(20),
                  const SizedBox(
                    height: 25,
                  ),
                  perpTime(20, 14,context),
                  const SizedBox(
                    height: 15,
                  ),
                  serve(20, 14,context),
                ],
              ),
              const SizedBox(
                width: 5,
              ),
              recipeImage(context.screenWidth/2 , 170, context),
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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      mealTypeWidget(12),
      InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      RecipeDetailsScreen(recipeDetails: widget.recipeDetails)),
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
              colories(10,context),
            ])
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ratingStars(14),
                const SizedBox(
                  height: 5,
                ),
                colories(10,context),
              ],
            ),
      const SizedBox(
        height: 5,
      ),
      MediaQuery.of(context).size.width < 450 && viewType == 4
          ? Column(
              children: [
                perpTime(15, 12,context),
                const SizedBox(
                  width: 10,
                ),
                serve(15, 12,context),
                const SizedBox(
                  height: 10,
                ),
              ],
            )
          : Row(
              children: [
                perpTime(15, 12,context),
                const SizedBox(
                  width: 10,
                ),
                serve(15, 12,context),
                const SizedBox(
                  height: 10,
                ),
              ],
            )
    ]);
  }

  Widget mealTypeWidget(double fontSize) {
    return Text(
      widget.recipeDetails.mealType!,
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
        widget.recipeDetails.title!,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
            fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black),
      ),
    );
  }

  Widget ratingStars(double size) {
    return VxRating(
        value: widget.recipeDetails.rating!.toDouble(),
        onRatingUpdate: (value) {},
        normalColor: ColorsApp.textfieldGrey,
        selectionColor: ColorsApp.PKColor,
        size: size,
        stepInt: true,
        count: 5);
  }

  Widget colories(double fontSize,BuildContext context) {
    return Text(
      "${widget.recipeDetails.calerios} ${S.of(context).calories}",
      style: TextStyle(fontSize: fontSize, color: ColorsApp.PKColor),
    );
  }

  Widget serve(double iconSize, double fontSize ,BuildContext context) {
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
          "${widget.recipeDetails.serving} ${S.of(context).serving}",
          style: TextStyle(color: ColorsApp.borderLine, fontSize: fontSize),
        ),
      ],
    );
  }

  Widget perpTime(double iconSize, double fontSize ,BuildContext context) {
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
          "${widget.recipeDetails.prepTime} ${S.of(context).mins}",
          style: TextStyle(color: ColorsApp.borderLine, fontSize: fontSize),
        ),
      ],
    );
  }

  Widget favoriteIcon() {
    Color favoriteColor;
    IconData favoriteIcon;
    if (widget.isFavorite!) {
      favoriteColor = ColorsApp.PKColor;
      favoriteIcon = Icons.favorite;
    } else {
      favoriteColor = ColorsApp.borderLine;
      favoriteIcon = Icons.favorite_outline;
    }
    return IconButton(
        onPressed: widget.onPressAction,
        icon: Icon(
          favoriteIcon,
          color: favoriteColor,
        ));
  }

  Widget closeIcon() {
    return IconButton(
        onPressed: widget.onPressAction,
        icon: const Icon(
          Icons.close,
          color: ColorsApp.PKColor,
        ));
  }

  Widget recipeImage(double width,double height, BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: CachedNetworkImage(
          imageUrl: widget.recipeDetails.image!,
          placeholder: (context, url) => Text(widget.recipeDetails.title!),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
