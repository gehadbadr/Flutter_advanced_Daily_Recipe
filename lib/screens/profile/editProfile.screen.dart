import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/models/user.models.dart';
import 'package:daily_recipe/providers/profile.providers.dart';
import 'package:daily_recipe/screens/profile/profile.screen.dart';
import 'package:daily_recipe/widgets/appbar.widgets.dart';
import 'package:daily_recipe/widgets/custom_button.dart';
import 'package:daily_recipe/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel profileDetails;
  const EditProfileScreen({super.key, required this.profileDetails});
//  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    Provider.of<ProfileController>(context, listen: false).providerInit();
    Provider.of<ProfileController>(context, listen: false).getFirstLetter(widget.profileDetails);
  }

  @override
  void deactivate() {
    Provider.of<ProfileController>(context, listen: false).providerDispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsApp.whiteColor,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: CustomAppBar(
                actionIcon: Icons.notification_add_outlined,
                onPressAction: () {})),
        body: SafeArea(
          child: SingleChildScrollView(child: Consumer<ProfileController>(
              builder: (context, profileController, child) {
                    profileController.nameController?.text =widget.profileDetails.name!;

            //  profileController.getUser(FirebaseAuth.instance.currentUser!.uid);
            //  Future.delayed(const Duration(seconds: 1), () {});
            if (widget.profileDetails == null) {
              return const CircularProgressIndicator();
            } else if (widget.profileDetails.name!.isEmpty ??
                false) {
              return const Text('No Data Found');
            } else {
              return Column(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    // mainAxisAlignment:MainAxisAlignment.center,
                    children: [
                      Container(
                          color: ColorsApp.PKColor,
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              widget.profileDetails.imageUrl == '' &&
                                      profileController.profileImgLink.isEmpty
                                  ? CircleAvatar(
                        radius: 40,
                        backgroundColor:ColorsApp.golden,
                        child: Text(Provider.of<ProfileController>(context, listen: false).firstLetter),
                      )
                                  : widget.profileDetails.imageUrl !=
                                              '' &&
                                          profileController
                                              .profileImgLink.isEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Image.network(
                                            widget.profileDetails.imageUrl!,
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ))
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Image.network(
                                            profileController.profileImgLink,
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          )),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomButton(
                                bgColor: ColorsApp.golden,
                                textColor: ColorsApp.whiteColor,
                                title: TextApp.change,
                                onPress: () async {
                                  profileController.uploadProfileImage(context);
                                },
                              ),
                              const Divider(),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          )),

                      /*Image.file(
                                      File(profileController
                                          .profileImgLink.value),
                                      width: 100,
                                      fit: BoxFit.cover)
                                  .box
                                  .roundedFull
                                  .clip(Clip.antiAlias)
                                  .make(),*/
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                          padding: const EdgeInsets.all(16.0),
                          width: context.screenWidth - 100,
                          decoration: BoxDecoration(
                              color: ColorsApp.golden,
                              borderRadius: BorderRadius.circular(10)),
                          child:  Form(
                              key: profileController.globalKey,
                            child: Column(
                              children: [
                                CustomTextField(
                                  title: TextApp.name,
                                  hint: TextApp.nameHint,
                                  controller: profileController.nameController,
                                  icon: Icons.person,
                                  isPass: false,
                                  onClick: (value) {
                                    profileController.nameController?.text =
                                        value!;
                                  },
                                ),
                                CustomTextField(
                                  title: TextApp.oldPassword,
                                  hint: TextApp.oldPasswordHint,
                                  controller:
                                      profileController.oldPasswordController,
                                  icon: Icons.lock,
                                  isPass: true,
                                  onClick: (value) {
                                    profileController
                                        .oldPasswordController?.text = value!;
                                  },
                                  passwordIcon: profileController.isPassword,
                                ),
                                CustomTextField(
                                  title: TextApp.newPassword,
                                  hint: TextApp.newPasswordHint,
                                  controller:
                                      profileController.newPasswordController,
                                  icon: Icons.lock,
                                  isPass: true,
                                  onClick: (value) {
                                    profileController
                                        .newPasswordController?.text = value!;
                                  },
                                  passwordIcon: profileController.isNewPassword,
                                ),CustomTextField(
                                      title: TextApp.repassword,
                                      hint: TextApp.repasswordHint,
                                      controller:
                                          profileController.rePasswordController,
                                      icon: Icons.lock,
                                      isPass: true,
                                      onClick: (value) {
                                        profileController
                                            .rePasswordController?.text = value!;
                                      },
                                      passwordIcon: profileController.isConfirmPassword,
                                      ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        width: 100,
                                        child: CustomButton(
                                          bgColor: ColorsApp.PKColor,
                                          textColor: ColorsApp.whiteColor,
                                          title: TextApp.save,
                                          onPress: () async {
                                            profileController.updateUser(context);
                                          },
                                        )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                        width: 100,
                                        child: CustomButton(
                                          bgColor: ColorsApp.PKColor,
                                          textColor: ColorsApp.whiteColor,
                                          title: TextApp.back,
                                          onPress: () {
                                                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProfileScreen(profileDetails: widget.profileDetails)),
                      );
                                          },
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          )),

                      // customTextField(
                      //     title: name,
                      //     hint: nameHint,
                      //     controller: profileController1.nameController,
                      //     isPass: false,
                      //     onClick: (value) {
                      //       profileController.nameController.text = value;
                      //     }),
                      // customTextField(
                      //     title: oldPassword,
                      //     hint: passwordHint,
                      //     controller: profileController.oldPasswordController,
                      //     isPass: true,
                      //     onClick: (value) {
                      //       profileController.oldPasswordController.text =
                      //           value;
                      //     }),
                      // customTextField(
                      //     title: newPassword,
                      //     hint: passwordHint,
                      //     controller: profileController.newPasswordController,
                      //     isPass: true,
                      //     onClick: (value) {
                      //       profileController.newPasswordController.text =
                      //           value;
                      //     }),
                      // 20.heightBox,
                      // profileController.isLoading.value
                      //     ? CircularProgressIndicator(
                      //         valueColor: AlwaysStoppedAnimation(redColor),
                      //       )
                      //     : SizedBox(
                      //         child: 'save'
                      //             .text
                      //             .fontFamily(semibold)
                      //             .align(TextAlign.center)
                      //             .white
                      //             .make(),
                      //       )
                      //         .box
                      //         .color(redColor)
                      //         .width(context.screenWidth - 60)
                      //         .roundedSM
                      //         .padding(EdgeInsets.all(10))
                      //         .make()
                      //         .onTap(() async {
                      //         /*  profileController.isLoading(true);
                      // if(globalkey.currentState!.validate()) {
                      //   globalkey.currentState?.save();
                      //   if(profileController.profileImgPath.value.isNotEmpty){
                      //     await profileController.uploadProfileImage();
                      //   }else{
                      //     profileController.profileImgLink = data['imageUrl'];
                      //   }
                      //   if( data['password'] == profileController.oldPasswordController.text){
                      //     await profileController.changeAuthPassword(
                      //         email: data['email'],
                      //         password: profileController.oldPasswordController.text,
                      //         newPassword: profileController.newPasswordController.text,
                      //         context: context
                      //     );
                      //     await profileController.updateProfile(
                      //         name: profileController.nameController.text,
                      //         password: profileController.newPasswordController.text,
                      //         imgUrl: profileController.profileImgLink
                      //     );
                      //     profileController.isLoading(false);
                      //     VxToast.show(context, msg: "Your data are updated");
                      //     Get.offAll(ProfileScreen());
                      //   }else{
                      //     VxToast.show(context, msg: "Wrong old password");
                      //     profileController.isLoading(false);
                      //   }
                      // }else{
                      //   profileController.isLoading(false);
                      // }*/
                      //       }),
                      10.heightBox,
                    ],
                  )
                  // .box
                  // .white
                  // .padding(EdgeInsets.all(18))
                  // .margin(EdgeInsets.symmetric(horizontal: 10))
                  // .roundedSM
                  // .shadowSm
                  // .make(),
                ],
              );
            }
          })),
        ));
  }
}
