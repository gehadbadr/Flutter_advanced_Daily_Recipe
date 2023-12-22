import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/providers/auth.providers.dart';
import 'package:daily_recipe/widgets/applogo.dart';
import 'package:daily_recipe/widgets/custom_button.dart';
import 'package:daily_recipe/widgets/custom_textfield.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = context.screenHeight;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgColor,
      body: BlurryModalProgressHUD(
        inAsyncCall: Provider.of<AuthController>(context).isLoading,
        blurEffectIntensity: 4,
        // progressIndicator: SpinKitFadingCircle(
        //   color: purpleColor,
        //   size: 90.0,
        // ),
        dismissible: true,
        opacity: 0.4,
        color: Colors.black87,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              //
              child: Image(image: AssetImage(imgBg), fit: BoxFit.fill),
            ),
             SingleChildScrollView(
                  child: Container(
                  height: context.screenHeight,
                  width: context.screenWidth,
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: (height * 0.1),
                        ),
                        appLogoWidget(),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Sign In',
                          style: TextStyle(
                              color: whiteColor, fontSize: 18, fontFamily: bold),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          padding: EdgeInsets.all(16),
                          width: context.screenWidth - 70,
                          child: Form(
                              key: _globalKey,
                              child: Column(
                                children: [
                                  CustomTextField(
                                    title: email,
                                    hint: emailHint,
                                    controller: emailController,
                                    icon: Icons.email,
                                    isPass: false,
                                    onClick: (value) {
                                      emailController.text = value!;
                                    },
                                  ),
                                  CustomTextField(
                                    title: password,
                                    hint: passwordHint,
                                    controller: passwordController,
                                    icon: Icons.lock,
                                    isPass: true,
                                    onClick: (value) {
                                      passwordController.text = value!;
                                    },
                                  ),
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: TextButton(
                                        onPressed: () {},
                                        child: Text(forgetPass),
                                      )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                      width: context.screenWidth - 50,
                                      child: CustomButton(
                                        bgColor: PKColor,
                                        textColor: whiteColor,
                                        title: login,
                                        onPress: () async {
                                          final authController =
                                              Provider.of<AuthController>(context,
                                                  listen: false);
                                          authController.changeisLoading(true);
                                          if (_globalKey.currentState!
                                              .validate()) {
                                            _globalKey.currentState?.save();
                                            try {
                                              String? emailValue =
                                                  authController.prefsFile!.getString('email');
                                              String? passwordValue = authController.prefsFile!
                                                  .getString('password');
                
                                              if (emailValue == null &&
                                                  passwordValue == null) {
                                                authController
                                                    .changeisLoading(false);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            errorNullloggedIn)));
                                              }
                                              if (emailValue !=
                                                      emailController.text ||
                                                  passwordValue !=
                                                      passwordController.text) {
                                                authController
                                                    .changeisLoading(false);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content:
                                                            Text(errorloggedIn)));
                                                authController
                                                    .changeisLoading(false);
                                              } else {
                                                authController.prefsFile!.setBool('login', true);
                                                authController
                                                    .changeisLoading(false);
                                                VxToast.show(context,
                                                    msg: loggedIn);
                                                Navigator.pushReplacementNamed(
                                                    context, 'HomepageScreen/');
                                              }
                                            } catch (e) {
                                              print(e.toString());
                                              authController
                                                  .changeisLoading(false);
                                            }
                                          } else {
                                            authController.changeisLoading(false);
                                          }
                                        },
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    loginWith,
                                    style: TextStyle(color: whiteColor),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                        3,
                                        (index) => Padding(
                                              padding: EdgeInsets.only(left: 8),
                                              child: CircleAvatar(
                                                  backgroundColor: lightGrey,
                                                  radius: 25,
                                                  child: Image.asset(
                                                    socialIconList[index],
                                                    width: 30,
                                                  )),
                                            )),
                                  ),
                                  SizedBox(
                                    height: context.screenHeight / 7,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, 'SignupScreen/');
                                      },
                                      child: RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: creatNewAccount,
                                              style: TextStyle(
                                                  fontFamily: bold,
                                                  color: fontGrey)),
                                          TextSpan(
                                              text: register,
                                              style: TextStyle(
                                                  fontFamily: bold,
                                                  color: PKColor))
                                        ]),
                                      )),
                                ],
                              )),
                        ),
                      ],
                    ),
                  )),
              ),
          
          ],
        ),
      ),
    );
  }
}
