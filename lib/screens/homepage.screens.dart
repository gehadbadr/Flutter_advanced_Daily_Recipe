import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/providers/auth.providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomepageScreen extends StatefulWidget {
  HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(builder: (context, authController, child) {
      String? name = authController.prefsFile!.getString('name');
      String? email = authController.prefsFile!.getString('email');
      String? password = authController.prefsFile!.getString('password');
      bool? login = authController.prefsFile!.getBool('login');
      return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          title: 'Home Page'.text.make(),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              child: Column(
            children: [
              40.heightBox,
              ListTile(
                  title: Column(
                    children: [
                      10.heightBox,
                      'Name :  ${name}  '.text.align(TextAlign.left).make(),
                      10.heightBox,
                      'Email : ${email}'.text.make(),
                      10.heightBox,
                      'Password : ******'.text.make(),
                    ],
                  ).box.alignCenterLeft.make(),
                  trailing: IconButton(
                    onPressed: () async {
                      await authController.logOut();
                      VxToast.show(context, msg: loggedOut);
                      Navigator.pushNamed(context, 'LoginScreen/');
                    },
                    icon: Icon(
                      Icons.logout_outlined,
                      color: PKColor,
                      size: 20,
                    ),
                  )).box.white.rounded.shadow.make(),
            ],
          )),
        ),
      );
    });
  }
}
