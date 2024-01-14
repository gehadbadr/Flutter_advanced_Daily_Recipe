import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/providers/auth.providers.dart';
import 'package:daily_recipe/reuseable_function/snackbar.function.dart';
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
  late GlobalKey<FormState> _globalKey;
  late TextEditingController nameController;
  late TextEditingController passwordController;
  late TextEditingController repasswordController;
  late TextEditingController emailController;
  bool? islogin = true;
  @override
  void initState() {
    _globalKey = GlobalKey<FormState>();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    repasswordController = TextEditingController();
    emailController = TextEditingController();
    super.initState();
  }

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
                                    title: TextApp.name,
                                    hint: TextApp.nameHint,
                                    controller: nameController,
                                    icon: Icons.person,
                                    isPass: false,
                                    onClick: (value) {
                                      nameController.text = value!;
                                    },
                                  ),
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
                                  CustomTextField(
                                    title: TextApp.repassword,
                                    hint: TextApp.repasswordHint,
                                    controller: repasswordController,
                                    icon: Icons.lock,
                                    isPass: true,
                                    onClick: (value) {
                                      passwordController.text = value!;
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
                                          final authController =
                                              Provider.of<AuthController>(
                                                  context,
                                                  listen: false);
                                          authController.changeisLoading(true);
                                          String? emailValue = authController
                                              .prefsFile
                                              .getString('email');
                                          if (emailController.text !=
                                              emailValue) {
                                            if (passwordController.text ==
                                                repasswordController.text) {
                                              if (_globalKey.currentState!
                                                  .validate()) {
                                                _globalKey.currentState?.save();
                                                try {
                                                  await Provider.of<
                                                              AuthController>(
                                                          context,
                                                          listen: false)
                                                      .savePrefs(
                                                    name: nameController.text,
                                                    email: emailController.text,
                                                    password:
                                                        passwordController.text,
                                                    login: islogin,
                                                  );
                                                  authController
                                                      .changeisLoading(false);
                                                  VxToast.show(context,
                                                      msg: TextApp
                                                          .registeredSuccessfully);
                                                  context.replaceNamed(
                                                      'HomepageScreen');
                                                } catch (e) {
                                                  print(e.toString());
                                                  authController
                                                      .changeisLoading(false);
                                                }
                                              } else {
                                                authController
                                                    .changeisLoading(false);
                                              }
                                            } else {
                                              authController
                                                  .changeisLoading(false);
                                              ShowSnackbar.showSnackbar(context,
                                                  TextApp.errorRepassword);
                                            }
                                          } else {
                                            authController
                                                .changeisLoading(false);
                                            ShowSnackbar.showSnackbar(context,
                                                TextApp.errorRegisteredBefore);
                                          }
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
                              context.goNamed('LoginScreen');
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
    );
  }
}
