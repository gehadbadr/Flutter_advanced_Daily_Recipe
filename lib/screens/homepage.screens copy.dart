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
    
      return Scaffold(
        backgroundColor: bgColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.centerLeft,
              child: Column(
            children: [
              40.heightBox,
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: whiteColor,
                ),
                child: ListTile(
                    title: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text('Name :  ${name}  ',style: TextStyle(fontSize: 16),),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Email : ${email}',style: TextStyle(fontSize: 16),),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Password : ******',style: TextStyle(fontSize: 16),),
                      ],
                    ),
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
                    )
                  ),
              ),
            ],
          )),
        ),
      );
    });
  }
}
