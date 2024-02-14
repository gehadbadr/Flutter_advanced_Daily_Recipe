import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/providers/auth.providers.dart';
import 'package:daily_recipe/widgets/applogo.dart';
import 'package:daily_recipe/widgets/custom_button.dart';
import 'package:daily_recipe/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    Provider.of<AuthController>(context, listen: false).providerInit();
  }

  @override
  Widget build(BuildContext context) {
    double height = context.screenHeight;
    return Consumer<AuthController>(
      builder: (context, authController, _) => Scaffold(
        backgroundColor: ColorsApp.bgColor,
        body: Stack(
          children: <Widget>[
            const Positioned.fill(
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
                         Text(
                          S.of(context).signup,
                          style: const TextStyle(
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
                              key: authController.globalKey,
                              child: Column(
                                children: [
                                  CustomTextField(
                                    title: S.of(context).name,
                                    hint: S.of(context).nameHint,
                                    controller: authController.nameController,
                                    icon: Icons.person,
                                    isPass: false,
                                    onClick: (value) {
                                      authController.nameController?.text =
                                          value!;
                                    },
                                  ),
                                  CustomTextField(
                                    title: S.of(context).email,
                                    hint: S.of(context).emailHint,
                                    controller: authController.emailController,
                                    icon: Icons.email,
                                    isPass: false,
                                    onClick: (value) {
                                      authController.emailController?.text =
                                          value!;
                                    },
                                  ),
                                  CustomTextField(
                                      title: S.of(context).password,
                                      hint: S.of(context).passwordHint,
                                      controller:
                                          authController.passwordController,
                                      icon: Icons.lock,
                                      isPass: true,
                                      onClick: (value) {
                                        authController
                                            .passwordController?.text = value!;
                                      },
                                      passwordIcon: authController.isPassword,
                                      ),
                                  CustomTextField(
                                    title: S.of(context).repassword,
                                    hint: S.of(context).repasswordHint,
                                    controller:
                                        authController.repasswordController,
                                    icon: Icons.lock,
                                    isPass: true,
                                    onClick: (value) {
                                      authController
                                          .repasswordController?.text = value!;
                                    },
                                    passwordIcon: authController.isConfirmPassword,
                                    ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  SizedBox(
                                      width: context.screenWidth - 50,
                                      child: CustomButton(
                                        bgColor: ColorsApp.PKColor,
                                        textColor: ColorsApp.whiteColor,
                                        title: S.of(context).signup,
                                        onPress: () async {
                                          authController.signUp(context);
                                        },
                                      )),
                                ],
                              )),
                        ),
                        SizedBox(
                          height: context.screenHeight / 7,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.loginScreen);
                            },
                            child: RichText(
                              text:  TextSpan(children: [
                                TextSpan(
                                    text: S.of(context).alreadyHaveAccount,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: ColorsApp.fontGrey,
                                        fontSize: 16)),
                                TextSpan(
                                    text: S.of(context).login,
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
