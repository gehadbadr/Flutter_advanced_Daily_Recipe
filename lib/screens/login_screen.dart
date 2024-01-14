import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/providers/auth.providers.dart';
import 'package:daily_recipe/reuseable_function/snackbar.function.dart';
import 'package:daily_recipe/widgets/applogo.dart';
import 'package:daily_recipe/widgets/custom_button.dart';
import 'package:daily_recipe/widgets/custom_textfield.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = context.screenHeight;

    return Scaffold(
      //  resizeToAvoidBottomInset: false,
      backgroundColor: ColorsApp.bgColor,
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
            const Positioned.fill(
              //
              child:
                  Image(image: AssetImage(ImagesPath.imgBg), fit: BoxFit.fill),
            ),
            SizedBox(
                height: context.screenHeight,
                width: context.screenWidth,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: (height * 0.1),
                        ),
                        const AppLogoWidget(),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Sign In',
                          style: TextStyle(
                              color: ColorsApp.whiteColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          decoration:
                              const BoxDecoration(color: Colors.black38),
                          padding: const EdgeInsets.all(16),
                          width: context.screenWidth - 70,
                          child: Form(
                              key: _globalKey,
                              child: Column(
                                children: [
                                  CustomTextField(
                                    title: TextApp.email,
                                    hint: TextApp.emailHint,
                                    controller: emailController,
                                    icon: Icons.email,
                                    isPass: false,
                                    onClick: (value) {
                                      emailController.text = value!;
                                    },
                                  ),
                                  CustomTextField(
                                    title: TextApp.password,
                                    hint: TextApp.passwordHint,
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
                                        child: const Text(TextApp.forgetPass),
                                      )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                      width: context.screenWidth - 50,
                                      child: CustomButton(
                                        bgColor: ColorsApp.PKColor,
                                        textColor: ColorsApp.whiteColor,
                                        title: TextApp.login,
                                        onPress: () async {
                                          final authController =
                                              Provider.of<AuthController>(
                                                  context,
                                                  listen: false);
                                          authController.changeisLoading(true);
                                          if (_globalKey.currentState!
                                              .validate()) {
                                            _globalKey.currentState?.save();
                                            try {
                                              String? emailValue =
                                                  authController.prefsFile
                                                      .getString('email');
                                              String? passwordValue =
                                                  authController.prefsFile
                                                      .getString('password');

                                              if (emailValue == null &&
                                                  passwordValue == null) {
                                                authController
                                                    .changeisLoading(false);
                                                ShowSnackbar.showSnackbar(
                                                    context,
                                                    TextApp.errorNullloggedIn);
                                              } else if (emailValue !=
                                                      emailController.text ||
                                                  passwordValue !=
                                                      passwordController.text) {
                                                authController
                                                    .changeisLoading(false);
                                                ShowSnackbar.showSnackbar(
                                                    context,
                                                    TextApp.errorloggedIn);
                                                authController
                                                    .changeisLoading(false);
                                              } else {
                                                authController.prefsFile
                                                    .setBool('login', true);
                                                authController
                                                    .changeisLoading(false);
                                                VxToast.show(context,
                                                    msg: TextApp.loggedIn);
                                                context
                                                    .replaceNamed('HomepageScreen');
                                              }
                                            } catch (e) {
                                              print(e.toString());
                                              authController
                                                  .changeisLoading(false);
                                            }
                                          } else {
                                            authController
                                                .changeisLoading(false);
                                          }
                                        },
                                      )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    TextApp.loginWith,
                                    style:
                                        TextStyle(color: ColorsApp.whiteColor),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                        3,
                                        (index) => Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8),
                                              child: CircleAvatar(
                                                  backgroundColor:
                                                      ColorsApp.lightGrey,
                                                  radius: 25,
                                                  child: Image.asset(
                                                    ListsApp
                                                        .socialIconList[index],
                                                    width: 30,
                                                  )),
                                            )),
                                  )
                                ],
                              )),
                        ),
                        SizedBox(
                          height: context.screenHeight / 7,
                        ),
                        InkWell(
                            onTap: () {
                              context.goNamed('SignupScreen');
                            },
                            child: RichText(
                              text: const TextSpan(children: [
                                TextSpan(
                                    text: TextApp.creatNewAccount,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: ColorsApp.fontGrey,
                                        fontSize: 16)),
                                TextSpan(
                                    text: TextApp.register,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: ColorsApp.PKColor,
                                        fontSize: 16))
                              ]),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
