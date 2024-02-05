import 'package:daily_recipe/models/user.models.dart';
import 'package:daily_recipe/providers/profile.providers.dart';
import 'package:daily_recipe/screens/homePage/home.components.dart';
import 'package:daily_recipe/widgets/drawer.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

class HomepageScreen extends StatefulWidget {
//  const HomepageScreen({super.key});
  final UserModel profileDetails;
  const HomepageScreen({super.key, required this.profileDetails});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  late ZoomDrawerController controller;

  @override
  void initState() {
    controller = ZoomDrawerController();
    init();
    super.initState();
  }

  void init() async {
    await Provider.of<ProfileController>(context, listen: false).getUser();
  }

  @override
  Widget build(BuildContext context) {
    // return Consumer<ProfileController>(
    //     builder: (context, profileController, child) {
    //   if (profileController.profileDetails.docid == null) {
    //    return  const Center(child: CircularProgressIndicator());
    //   } else {
        //  profileController.getUser;
        return ZoomDrawer(
          slideWidth: MediaQuery.of(context).size.width * 0.65,
          menuBackgroundColor: Colors.white,
          boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 5)],
          disableDragGesture: true,
          mainScreenTapClose: true,
          controller: controller,
          drawerShadowsBackgroundColor: Colors.grey,
          menuScreen: DrawerWidget(
              controller: controller,
              profileDetails: widget.profileDetails),
          mainScreen: HomeWidget(
              controller: controller,
              profileDetails: widget.profileDetails),
          borderRadius: 24.0,
          showShadow: true,
          angle: -12.0,
        );
    //   }
    // });
  }
}
// Widget scaffold(controller) {
//   return 
//   Scaffold(
//     backgroundColor: ColorsApp.whiteColor,
//     appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(60.0),
//         child: CustomAppBar(
//             leadingIcon: Icons.menu,
//             actionIcon: Icons.notification_add_outlined,
//             onPressLeading: () {
//               controller.toggle!();
//             },
//             onPressAction: () {})),
//     body: SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: Column(
//             children: [
//               Consumer<AuthController>(
//                   builder: (context, authController, child) {
//                 authController.getDisplayName();
//                 String? name = authController.displayName;

//                 return Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text('${TextApp.bonjour}, $name',
//                         style: const TextStyle(
//                             fontSize: 20, color: ColorsApp.fontGrey)));
//               }),
//               const SizedBox(
//                 height: 10,
//               ),
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   TextApp.whatToCook,
//                   style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     flex: 4,
//                     child: Container(
//                         alignment: Alignment.center,
//                         height: 60,
//                         width: 200,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: ColorsApp.lightGrey,
//                         ),
//                         child: TextFormField(
//                           cursorColor: ColorsApp.borderLine,
//                           decoration: const InputDecoration(
//                               border: OutlineInputBorder(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(10.0)),
//                                 borderSide: BorderSide(
//                                   width: 0,
//                                   style: BorderStyle.none,
//                                 ),
//                               ),
//                               prefixIcon: Icon(
//                                 Icons.search,
//                                 color: ColorsApp.borderLine,
//                               ),
//                               filled: true,
//                               fillColor: ColorsApp.lightGrey,
//                               hintText: TextApp.searchAnyThing,
//                               hintStyle:
//                                   TextStyle(color: ColorsApp.borderLine)),
//                         )),
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: Container(
//                       height: 60,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: ColorsApp.lightGrey),
//                       child: IconButton(
//                         onPressed: () {},
//                         icon: const Icon(
//                           Icons.tune,
//                           //  size: 25,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               const CarsoulWidget(),
//               const SizedBox(
//                 height: 10,
//               ),
//               Consumer<RecipeController>(
//                   builder: (context, recipeController, child) {
//                 recipeController.getRecipes();
//                 return Column(
//                   children: [
//                     const Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: Text(
//                             TextApp.todayFreshRecipe,
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w700, fontSize: 20),
//                           ),
//                         ),
//                         Text(
//                           TextApp.seeAll,
//                           style:
//                               TextStyle(color: ColorsApp.PKColor, fontSize: 16),
//                         )
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     recipeController.recipesList!.isEmpty
//                         ? const CircularProgressIndicator()
//                         : SingleChildScrollView(
//                             scrollDirection: Axis.horizontal,
//                             physics: const BouncingScrollPhysics(),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: List.generate(
//                                   recipeController.recipesList!.length,
//                                   (index) => Recipes(
//                                         id: recipeController
//                                             .recipesList![index].id,
//                                         title: recipeController
//                                             .recipesList![index].title!,
//                                         image: recipeController
//                                             .recipesList![index].image,
//                                         mealType: recipeController
//                                             .recipesList![index].mealType,
//                                         rating: recipeController
//                                             .recipesList![index].rating,
//                                         calerios: recipeController
//                                             .recipesList![index].calerios,
//                                         serving: recipeController
//                                             .recipesList![index].serving,
//                                         prepTime: recipeController
//                                             .recipesList![index].prepTime,
//                                         viewType: 0,
//                                       )),
//                             ),
//                           ),
//                     const Divider(),
//                     const Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: Text(
//                             TextApp.recomended,
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w700, fontSize: 20),
//                           ),
//                         ),
//                         Text(
//                           TextApp.seeAll,
//                           style:
//                               TextStyle(color: ColorsApp.PKColor, fontSize: 16),
//                         )
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     recipeController.recommendedList!.isEmpty
//                         ? const CircularProgressIndicator()
//                         : SingleChildScrollView(
//                             scrollDirection: Axis.horizontal,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: List.generate(
//                                 recipeController.recommendedList!.length,
//                                 (index) => Recipes(
//                                     id: recipeController
//                                         .recommendedList![index].id,
//                                     title: recipeController
//                                         .recommendedList![index].title!,
//                                     image: recipeController
//                                         .recommendedList![index].image,
//                                     mealType: recipeController
//                                         .recommendedList![index].mealType,
//                                     rating: recipeController
//                                         .recommendedList![index].rating,
//                                     calerios: recipeController
//                                         .recommendedList![index].calerios,
//                                     serving: recipeController
//                                         .recommendedList![index].serving,
//                                     prepTime: recipeController
//                                         .recommendedList![index].prepTime,
//                                     viewType: 1),
//                               ),
//                             ),
//                           ),
//                   ],
//                 );
//                 //}
//               })
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }
