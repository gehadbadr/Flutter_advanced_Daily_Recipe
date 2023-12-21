
import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/providers/auth.providers.dart';
import 'package:daily_recipe/services/prefrences.services.dart';
import 'package:daily_recipe/widgets/applogo.dart';
import 'package:daily_recipe/widgets/custom_button.dart';
import 'package:daily_recipe/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});
  
  @override
  State<SignupScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SignupScreen> {
  bool? isCheck = false;
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var repasswordController = TextEditingController();
  var emailController = TextEditingController();
  final prefsFile = PrefrencesService.prefs;
  bool? islogin = true;

  @override
  Widget build(BuildContext context) {
      double height = context.screenHeight;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgColor,
      body:BlurryModalProgressHUD(
            inAsyncCall: Provider.of<AuthController>(context).isLoading,
            blurEffectIntensity: 4,
            // progressIndicator: SpinKitFadingCircle(
            //   color: purpleColor,
            //   size: 90.0,
            // ),
            dismissible: true,
            opacity: 0.4,
            color: Colors.black87,
        child: SingleChildScrollView(
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                (height * 0.1).heightBox,
                appLogoWidget(),
                10.heightBox,
                "Join to ${appname}"
                    .text
                    .fontFamily(bold)
                    .color(PKColor)
                    .size(18)
                    .make(),
                20.heightBox,
                Form(
                  key: _globalKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        title: name,
                        hint: nameHint,
                        controller: nameController,
                        isPass: false,
                        onClick: (value) {
                          nameController.text = value!;
                        },
                        icon: Icons.person,
                      ),
                      CustomTextField(
                        title: email,
                        hint: emailHint,
                        controller: emailController,
                        onClick: (value) {
                          emailController.text = value!;
                        },
                        icon: Icons.email,
                        isPass: false,
                      ),
                      CustomTextField(
                        title: password,
                        hint: passwordHint,
                        controller: passwordController,
                        onClick: (value) {
                          passwordController.text = value!;
                        },
                        icon: Icons.lock,
                        isPass: true,
                      ),
                      CustomTextField(
                        title: repassword,
                        hint: repasswordHint,
                        controller: repasswordController,
                        onClick: (value) {
                          repasswordController.text = value!;
                        },
                        icon: Icons.lock,
                        isPass: true,
                      ),
                      10.heightBox,
                      Row(
                        children: [
                          Checkbox(
                            value: isCheck,
                            onChanged: (value) {
                              setState(() {
                                isCheck = value;
                              });
                            },
                            checkColor: PKColor,
                            activeColor: whiteColor,
                          ),
                          5.widthBox,
                          Expanded(
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "I agree to the ",
                                    style: TextStyle(
                                        fontFamily: regular, color: fontGrey)),
                                TextSpan(
                                    text: termAndCond,
                                    style: TextStyle(
                                        fontFamily: bold, color: PKColor)),
                                TextSpan(
                                    text: " & ",
                                    style: TextStyle(
                                        fontFamily: regular, color: fontGrey)),
                                TextSpan(
                                    text: privacyPolicy,
                                    style: TextStyle(
                                        fontFamily: bold, color: PKColor))
                              ]),
                            ),
                          ),
                        ],
                      ),
                      10.heightBox,
                      CustomButton(
                        bgColor: PKColor,
                        textColor: whiteColor,
                        title: signup,
                        onPress: () async {
                           final modelHud = Provider.of<AuthController>(context, listen: false);
                           modelHud.changeisLoading(true);
                          if(isCheck == true){

                            if(passwordController.text == repasswordController.text){
                              if (_globalKey.currentState!.validate()) {
                                _globalKey.currentState?.save();
                                try {
                                  await PrefrencesService.savePrefs(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    login: islogin,
                                  );
                                    modelHud.changeisLoading(false);
                                    VxToast.show(context, msg:registeredSuccessfully);
                                    Navigator.pushReplacementNamed(context, 'HomepageScreen/');
                                } catch (e) {
                                  print(e.toString());
                                  modelHud.changeisLoading(false);
                                }
                              } else {
                                modelHud.changeisLoading(false);
                              }
                            }else{
                              modelHud.changeisLoading(false);
                              ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(errorRepassword)));
                            }
                          }else{
                            modelHud.changeisLoading(false);
                            ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(errorAgree)));
                          }
                        },
                      ).box.width(context.screenWidth - 50).make(),
                      10.heightBox,
                      10.heightBox,
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: alreadyHaveAccount,
                              style:
                                  TextStyle(fontFamily: bold, color: fontGrey)),
                          TextSpan(
                              text: login,
                              style: TextStyle(fontFamily: bold, color: PKColor))
                        ]),
                      ).onTap(() async {
                         Navigator.pushNamed(context, 'LoginScreen/');
                      }),
                      10.heightBox,
                    ],
                  )
                      .box
                      .white
                      .rounded
                      .padding(EdgeInsets.all(16))
                      .width(context.screenWidth - 70)
                      .shadowSm
                      .make(),
                ),
              ],
            ),
          )),
        ),
      ),
    );

  }
}
/*
class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  bool? isCheck = false;
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var repasswordController = TextEditingController();
  var emailController = TextEditingController();
  final prefsFile = PrefrencesService.prefs;
  bool? islogin = true;

  @override
  Widget build(BuildContext context) {
    double height = context.screenHeight;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgColor,
      body:BlurryModalProgressHUD(
            inAsyncCall: Provider.of<ModelHud>(context).isLoading,
            blurEffectIntensity: 4,
            // progressIndicator: SpinKitFadingCircle(
            //   color: purpleColor,
            //   size: 90.0,
            // ),
            dismissible: true,
            opacity: 0.4,
            color: Colors.black87,
        child: SingleChildScrollView(
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                (height * 0.1).heightBox,
                appLogoWidget(),
                10.heightBox,
                "Join to ${appname}"
                    .text
                    .fontFamily(bold)
                    .color(PKColor)
                    .size(18)
                    .make(),
                20.heightBox,
                Form(
                  key: _globalKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        title: name,
                        hint: nameHint,
                        controller: nameController,
                        isPass: false,
                        onClick: (value) {
                          nameController.text = value!;
                        },
                        icon: Icons.person,
                      ),
                      CustomTextField(
                        title: email,
                        hint: emailHint,
                        controller: emailController,
                        onClick: (value) {
                          emailController.text = value!;
                        },
                        icon: Icons.email,
                        isPass: false,
                      ),
                      CustomTextField(
                        title: password,
                        hint: passwordHint,
                        controller: passwordController,
                        onClick: (value) {
                          passwordController.text = value!;
                        },
                        icon: Icons.lock,
                        isPass: true,
                      ),
                      CustomTextField(
                        title: repassword,
                        hint: repasswordHint,
                        controller: repasswordController,
                        onClick: (value) {
                          repasswordController.text = value!;
                        },
                        icon: Icons.lock,
                        isPass: true,
                      ),
                      10.heightBox,
                      Row(
                        children: [
                          Checkbox(
                            value: isCheck,
                            onChanged: (value) {
                              setState(() {
                                isCheck = value;
                              });
                            },
                            checkColor: PKColor,
                            activeColor: whiteColor,
                          ),
                          5.widthBox,
                          Expanded(
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "I agree to the ",
                                    style: TextStyle(
                                        fontFamily: regular, color: fontGrey)),
                                TextSpan(
                                    text: termAndCond,
                                    style: TextStyle(
                                        fontFamily: bold, color: PKColor)),
                                TextSpan(
                                    text: " & ",
                                    style: TextStyle(
                                        fontFamily: regular, color: fontGrey)),
                                TextSpan(
                                    text: privacyPolicy,
                                    style: TextStyle(
                                        fontFamily: bold, color: PKColor))
                              ]),
                            ),
                          ),
                        ],
                      ),
                      10.heightBox,
                      CustomButton(
                        bgColor: PKColor,
                        textColor: whiteColor,
                        title: signup,
                        onPress: () async {
                           final modelHud = Provider.of<ModelHud>(context, listen: false);
                           modelHud.changeisLoading(true);
                          if(passwordController.text == repasswordController.text){
                            if (_globalKey.currentState!.validate()) {
                              _globalKey.currentState?.save();
                              try {
                                await PrefrencesService.savePrefs(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  login: islogin,
                                );
                                  modelHud.changeisLoading(false);
                                  VxToast.show(context, msg:registeredSuccessfully);
                                  Navigator.pushNamed(context, 'HomepageScreen/');
                              } catch (e) {
                                print(e.toString());
                                modelHud.changeisLoading(false);
                              }
                            } else {
                              modelHud.changeisLoading(false);
                            }
                          }else{
                            VxToast.show(context, msg:errorRepassword);
                            modelHud.changeisLoading(false);
                          }
                        },
                      ).box.width(context.screenWidth - 50).make(),
                      10.heightBox,
                      10.heightBox,
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: alreadyHaveAccount,
                              style:
                                  TextStyle(fontFamily: bold, color: fontGrey)),
                          TextSpan(
                              text: login,
                              style: TextStyle(fontFamily: bold, color: PKColor))
                        ]),
                      ).onTap(() async {
                         Navigator.pushNamed(context, 'LoginScreen/');
                      }),
                      10.heightBox,
                    ],
                  )
                      .box
                      .white
                      .rounded
                      .padding(EdgeInsets.all(16))
                      .width(context.screenWidth - 70)
                      .shadowSm
                      .make(),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
*/