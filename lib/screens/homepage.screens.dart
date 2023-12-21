import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/services/prefrences.services.dart';
import 'package:flutter/material.dart';

class HomepageScreen extends StatefulWidget {
  HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  void initState() {
    super.initState();
    getName();
  }

  final prefsFile = PrefrencesService.prefs;
  String? name;
  String? email;
  String? password;
  bool? login;
  Future getName() async {
    String? userValue = prefsFile!.getString('name');
    String? emailValue = prefsFile!.getString('email');
    String? passwordValue = prefsFile!.getString('password');
    bool? loginValue = prefsFile!.getBool('login');
    setState(() {
      name = userValue;
      email = emailValue;
      password = passwordValue;
      login = loginValue;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    await PrefrencesService.logOut();
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
  }
}
