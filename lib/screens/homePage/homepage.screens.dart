import 'package:daily_recipe/models/user.models.dart';
import 'package:daily_recipe/providers/lang.providers.dart';
import 'package:daily_recipe/screens/homePage/home.components.dart';
import 'package:daily_recipe/widgets/drawer.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

class HomepageScreen extends StatefulWidget {
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
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    
    return ZoomDrawer(
      isRtl: Provider.of<LangController>(context, listen: false).isArabic(),
      slideWidth: MediaQuery.of(context).size.width * 0.65,
      menuBackgroundColor: Colors.white,
      boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 5)],
      disableDragGesture: true,
      mainScreenTapClose: true,
      controller: controller,
      drawerShadowsBackgroundColor: Colors.grey,
      menuScreen: DrawerWidget(
          controller: controller, profileDetails: widget.profileDetails),
      mainScreen: HomeWidget(
          controller: controller,
          profileDetails: widget.profileDetails,
          isArabic: Provider.of<LangController>(context, listen: false).isArabic()),
      borderRadius: 24.0,
      showShadow: true,
      angle: -12.0,
    );
    //   }
    // });
  }
}
