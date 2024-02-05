import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/models/user.models.dart';
import 'package:daily_recipe/providers/auth.providers.dart';
import 'package:daily_recipe/providers/profile.providers.dart';
import 'package:daily_recipe/screens/homePage/homepage.screens.dart';
import 'package:daily_recipe/screens/profile/editProfile.screen.dart';
import 'package:daily_recipe/widgets/appbar.widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final UserModel profileDetails;
  const ProfileScreen({super.key, required this.profileDetails});
  //const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
      init();
    super.initState();
  }

  void init() async {
    Provider.of<ProfileController>(context, listen: false).getFirstLetter(widget.profileDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsApp.whiteColor,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: CustomAppBar(
                    leadingIcon: Icons.arrow_back,
                onPressLeading: () {
                  Provider.of<ProfileController>(context, listen: false)
                      .getUser();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomepageScreen(
                            profileDetails: Provider.of<ProfileController>(
                                    context,
                                    listen: false)
                                .profileDetails)),
                  );
                },
                actionIcon: Icons.notification_add_outlined,
                onPressAction: () {})),
        body: SafeArea(
          child: SingleChildScrollView(
              // child: FutureBuilder(
              //     future: FirebaseFirestore.instance
              //         .collection('users')
              //         .doc(FirebaseAuth.instance.currentUser!.uid)
              //         .get(),
              //     builder: (context, snapShot) {
              //       if (snapShot.connectionState == ConnectionState.waiting) {
              //         return const CircularProgressIndicator();
              //       } else {
              //         UserModel profileDetails = UserModel();

              //         try {
              //           var result = snapShot.data!;
              //           if (result.data() != null) {
              //             profileDetails =
              //                 UserModel.fromJson(result.data()!, result.id);
              //           }
              //         } catch (e) {
              //           print(e.toString());
              //         }
                       child: Container(
                        height: 200,
                        color: ColorsApp.PKColor,
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: Icon(
                                    Icons.edit,
                                    color: ColorsApp.whiteColor,
                                  )),
                            ).onTap(() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditProfileScreen(profileDetails: widget.profileDetails)),
                                  );
                //  Navigator.pushNamed(context, AppRoutes.editprofileScreen);
                            }),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: [
                                  widget.profileDetails.imageUrl == ''
                                      ? CircleAvatar(
                        radius: 40,
                        backgroundColor:ColorsApp.golden,
                        child: Text(Provider.of<ProfileController>(context, listen: false).firstLetter),
                      )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: CachedNetworkImage(
                                            imageUrl: widget.profileDetails.imageUrl!,
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),),
                                  Expanded(
                                      child: Column(
                                    children: [
                                      Text(widget.profileDetails.name!,
                                          style: const TextStyle(
                                              color: ColorsApp.whiteColor,fontWeight: FontWeight.w700)),
                                      Text(widget.profileDetails.email!,
                                          style: const TextStyle(
                                              color: ColorsApp.whiteColor,fontWeight: FontWeight.w600)),
                                    ],
                                  )),
                                  OutlinedButton(
                                    onPressed: () async {
                                      final authController =
                                          Provider.of<AuthController>(context,
                                              listen: false);
                                      authController.signoutMethod(context);
                                    },
                                    child: Text(TextApp.logout,
                                        style: TextStyle(
                                            color: ColorsApp.whiteColor)),
                                    style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                            color: ColorsApp.whiteColor)),
                                  )
                                ],
                              ),
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //   children: [
                            //     cardDetails(count:data['cart_count'] ,title:"in your cart",width:context.screenWidth/3.4),
                            //     cardDetails(count:data['wishlist_count'] ,title:"in your wish list",width:context.screenWidth/3.4),
                            //     cardDetails(count:data['order_count'] ,title:"your orders",width:context.screenWidth/3.4),
                            //   ],
                            // ).box.color(redColor).padding(EdgeInsets.symmetric(vertical: 20)).make(),
                            //   Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //     children: [
                            //       Column(
                            //         children: [
                            //           Icon(Icons.language,size: 22,color: whiteColor,),
                            //           "Language".text.white.fontFamily(semibold).make()
                            //         ],
                            //       )    ,
                            //       Column(
                            //         children: [
                            //           Icon(Icons.language,size: 22,color: whiteColor,),
                            //           "Language".text.white.fontFamily(semibold).make()
                            //         ],
                            //       )    ,
                            //       Column(
                            //         children: [
                            //           Icon(Icons.language,size: 22,color: whiteColor,),
                            //           "Language".text.white.fontFamily(semibold).make()
                            //         ],
                            //       )    ,
                            //     ],
                            //   ).box.padding(EdgeInsets.only(bottom: 20)).color(redColor).make(),
                            //   ListView.separated(
                            //     shrinkWrap: true,
                            //     itemCount: profileListViewitem.length,
                            //     itemBuilder: (context,index){return ListTile(
                            //       title: profileListViewitem[index].text.color(darkFontGrey).fontFamily(semibold).make(),
                            //       leading: Image.asset(profileListViewImages[index],width: 22,),
                            //     ).box.white.make();},
                            //     separatorBuilder: (context,index){return Divider(color: lightGrey,) ;},
                            //   ).box.white.roundedSM.shadowSm.margin(EdgeInsets.all(12)).padding(EdgeInsets.symmetric(horizontal: 16)).make().box.color(redColor).make(),
                          ],
                        ),
                      )
                    
                  ),
        ));
  }
}
