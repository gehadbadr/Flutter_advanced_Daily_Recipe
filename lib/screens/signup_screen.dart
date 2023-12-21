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
                child: Center(
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
                                  title: name,
                                  hint: nameHint,
                                  controller: nameController,
                                  icon: Icons.person,
                                  isPass: false,
                                  onClick: (value) {
                                    nameController.text = value!;
                                  },
                                ),
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
                                CustomTextField(
                                  title: repassword,
                                  hint: repasswordHint,
                                  controller: repasswordController,
                                  icon: Icons.lock,
                                  isPass: true,
                                  onClick: (value) {
                                    passwordController.text = value!;
                                  },
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                    width: context.screenWidth - 50,
                                    child: CustomButton(
                                      bgColor: PKColor,
                                      textColor: whiteColor,
                                      title: signup,
                                      onPress: () async {
                                        final modelHud =
                                            Provider.of<AuthController>(context,
                                                listen: false);
                                        modelHud.changeisLoading(true);
                                        if (passwordController.text ==
                                            repasswordController.text) {
                                          if (_globalKey.currentState!
                                              .validate()) {
                                            _globalKey.currentState?.save();
                                            try {
                                              await PrefrencesService.savePrefs(
                                                name: nameController.text,
                                                email: emailController.text,
                                                password:
                                                    passwordController.text,
                                                login: islogin,
                                              );
                                              modelHud.changeisLoading(false);
                                              VxToast.show(context,
                                                  msg: registeredSuccessfully);
                                              Navigator.pushReplacementNamed(
                                                  context, 'HomepageScreen/');
                                            } catch (e) {
                                              print(e.toString());
                                              modelHud.changeisLoading(false);
                                            }
                                          } else {
                                            modelHud.changeisLoading(false);
                                          }
                                        } else {
                                          modelHud.changeisLoading(false);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content:
                                                      Text(errorRepassword)));
                                        }
                                      },
                                    )),
                                SizedBox(
                                  height: 70,
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
