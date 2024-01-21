import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/providers/auth.providers.dart';
import 'package:daily_recipe/widgets/applogo.dart';
import 'package:daily_recipe/widgets/custom_button.dart';
import 'package:daily_recipe/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SignupScreen> {
  
  @override
  void initState() {
    Provider.of<AuthController>(context, listen: false).providerInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = context.screenHeight;

    return Consumer<AuthController>(
            builder: (context, authController, _) =>
      Scaffold(
        backgroundColor: ColorsApp.bgColor,
        body: BlurryModalProgressHUD(
          inAsyncCall: authController.isLoading,
          blurEffectIntensity: 4,
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
                                key:authController.globalKey,
                                child: Column(
                                  children: [
                                    CustomTextField(
                                      title: TextApp.name,
                                      hint: TextApp.nameHint,
                                      controller: authController.nameController,
                                      icon: Icons.person,
                                      isPass: false,
                                      onClick: (value) {
                                        authController.nameController?.text = value!;
                                      },
                                    ),
                                    CustomTextField(
                                      title: TextApp.email,
                                      hint: TextApp.emailHint,
                                      controller: authController.emailController,
                                      icon: Icons.email,
                                      isPass: false,
                                      onClick: (value) {
                                        authController.emailController?.text = value!;
                                      },
                                    ),
                                    CustomTextField(
                                      title: TextApp.password,
                                      hint: TextApp.passwordHint,
                                      controller: authController.passwordController,
                                      icon: Icons.lock,
                                      isPass: true,
                                      onClick: (value) {
                                        authController.passwordController?.text = value!;
                                      },
                                    ),
                                    CustomTextField(
                                      title: TextApp.repassword,
                                      hint: TextApp.repasswordHint,
                                      controller: authController.repasswordController,
                                      icon: Icons.lock,
                                      isPass: true,
                                      onClick: (value) {
                                        authController.passwordController?.text = value!;
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
                                          title: TextApp.signup,
                                          onPress: () async {
                                            authController.signUp(context);
                                          },
                                        )),
                                  ],
                                )),
                          ),
                          const SizedBox(
                            height: 70,
                          ),
                          InkWell(
                              onTap: () {
                                 Navigator.pushNamed(context,AppRoutes.loginScreen);
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
      ),
    );
  }
}
