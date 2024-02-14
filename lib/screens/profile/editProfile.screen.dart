import 'package:cached_network_image/cached_network_image.dart';
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
    Provider.of<ProfileController>(context, listen: false)
        .getFirstLetter(widget.profileDetails);
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
                leadingIcon: Icons.arrow_back,
                onPressLeading: () async {
                  await Provider.of<ProfileController>(context, listen: false)
                      .getUser();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileScreen(
                            profileDetails: Provider.of<ProfileController>(
                                    context,
                                    listen: false)
                                .profileDetails)),
                  );
                },
                actionIcon: Icons.language,
                onPressAction: () {})),
        body: SafeArea(
          child: SingleChildScrollView(child: Consumer<ProfileController>(
              builder: (context, profileController, child) {
            profileController.nameController?.text =
                widget.profileDetails.name!;

            if (widget.profileDetails == null) {
              return const CircularProgressIndicator();
            } else if (widget.profileDetails.name!.isEmpty /* ?? false*/) {
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
                                      backgroundColor: ColorsApp.golden,
                                      child: Text(
                                          Provider.of<ProfileController>(
                                                  context,
                                                  listen: false)
                                              .firstLetter),
                                    )
                                  : widget.profileDetails.imageUrl != '' &&
                                          profileController
                                              .profileImgLink.isEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                widget.profileDetails.imageUrl!,
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        )
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
                                title: S.of(context).change,
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
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                          padding: const EdgeInsets.all(16.0),
                          width: context.screenWidth - 100,
                          decoration: BoxDecoration(
                              color: ColorsApp.golden,
                              borderRadius: BorderRadius.circular(10)),
                          child: Form(
                            key: profileController.globalKey,
                            child: Column(
                              children: [
                                CustomTextField(
                                  title: S.of(context).name,
                                  hint: S.of(context).nameHint,
                                  controller: profileController.nameController,
                                  icon: Icons.person,
                                  isPass: false,
                                  onClick: (value) {
                                    profileController.nameController?.text =
                                        value!;
                                  },
                                ),
                                // CustomTextField(
                                //   title: S.of(context).oldPassword,
                                //   hint: S.of(context).oldPasswordHint,
                                //   controller:
                                //       profileController.oldPasswordController,
                                //   icon: Icons.lock,
                                //   isPass: true,
                                //   onClick: (value) {
                                //     profileController
                                //         .oldPasswordController?.text = value!;
                                //   },
                                //   passwordIcon: profileController.isPassword,
                                // ),
                                // CustomTextField(
                                //   title: S.of(context).newPassword,
                                //   hint: S.of(context).newPasswordHint,
                                //   controller:
                                //       profileController.newPasswordController,
                                //   icon: Icons.lock,
                                //   isPass: true,
                                //   onClick: (value) {
                                //     profileController
                                //         .newPasswordController?.text = value!;
                                //   },
                                //   passwordIcon: profileController.isNewPassword,
                                // ),CustomTextField(
                                //       title: S.of(context).repassword,
                                //       hint: S.of(context).repasswordHint,
                                //       controller:
                                //           profileController.rePasswordController,
                                //       icon: Icons.lock,
                                //       isPass: true,
                                //       onClick: (value) {
                                //         profileController
                                //             .rePasswordController?.text = value!;
                                //       },
                                //       passwordIcon: profileController.isConfirmPassword,
                                //       ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        width: 100,
                                        child: CustomButton(
                                          bgColor: ColorsApp.PKColor,
                                          textColor: ColorsApp.whiteColor,
                                          title: S.of(context).save,
                                          onPress: () async {
                                            profileController
                                                .updateUser(context);
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
                                          title: S.of(context).back,
                                          onPress: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProfileScreen(
                                                          profileDetails: widget
                                                              .profileDetails)),
                                            );
                                          },
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          )),
                      10.heightBox,
                    ],
                  )
                ],
              );
            }
          })),
        ));
  }
}
