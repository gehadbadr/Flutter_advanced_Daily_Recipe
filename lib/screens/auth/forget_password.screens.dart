import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/providers/auth.providers.dart';
import 'package:daily_recipe/widgets/applogo.dart';
import 'package:daily_recipe/widgets/custom_button.dart';
import 'package:daily_recipe/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
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
                        const Text(
                          TextApp.resetPassword,
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
                              key: authController.globalKey,
                              child: Column(
                                children: [
                                  CustomTextField(
                                    title: TextApp.email,
                                    hint: TextApp.emailHint,
                                    controller: authController.emailController,
                                    icon: Icons.email,
                                    isPass: false,
                                    onClick: (value) {
                                      authController.emailController?.text =
                                          value!;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  SizedBox(
                                      width: context.screenWidth - 50,
                                      child: CustomButton(
                                        bgColor: ColorsApp.PKColor,
                                        textColor: ColorsApp.whiteColor,
                                        title: TextApp.resetPassword,
                                        onPress: () async {
                                          authController.resetPassword(context);
                                        },
                                      )),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                ],
                              )),
                        ),
                        SizedBox(
                          height: (height * 0.4),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.loginScreen);
                            },
                            child: RichText(
                              text: const TextSpan(children: [
                                TextSpan(
                                    text: TextApp.alreadyHaveAccount,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: ColorsApp.fontGrey,
                                        fontSize: 16)),
                                TextSpan(
                                    text: TextApp.login,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: ColorsApp.PKColor,
                                        fontSize: 16))
                              ]),
                            )),
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
