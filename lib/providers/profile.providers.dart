import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/consts/toastStatus.dart';
import 'package:daily_recipe/models/user.models.dart';
import 'package:daily_recipe/reuseable_function/toast.function.dart';
import 'package:daily_recipe/screens/profile/profile.screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:overlay_kit/overlay_kit.dart';

class ProfileController extends ChangeNotifier {
  final auth = FirebaseAuth.instance;

  var profileImgLink = '';
  UserModel profileDetails = UserModel();

  late GlobalKey<FormState>? _globalKey;
  late TextEditingController? nameController;
  late TextEditingController? oldPasswordController;
  late TextEditingController? newPasswordController;
  late TextEditingController? rePasswordController;
  GlobalKey<FormState>? get globalKey => _globalKey;

  String firstLetter = '';

  void providerInit() {
    _globalKey = GlobalKey<FormState>();
    nameController = TextEditingController();
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    rePasswordController = TextEditingController();
  }

  void providerDispose() {
    oldPasswordController = null;
    rePasswordController = null;
    newPasswordController = null;
    _globalKey = null;
    nameController = null;
  }

  Future<void> getUser() async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (result.data() != null) {
        profileDetails = UserModel.fromJson(result.data()!, result.id);
      } else {
        return;
      }
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  void getFirstLetter(UserModel profileDetails) {
    var name = profileDetails.name!;
    firstLetter = name[0].toUpperCase();
  }

  void uploadProfileImage(BuildContext context) async {
    OverlayLoadingProgress.start();

    var imageResult = await FilePicker.platform
        .pickFiles(type: FileType.image, withData: true);

    var refresnce =
        FirebaseStorage.instance.ref('users/${imageResult?.files.first.name}');

    if (imageResult?.files.first.bytes != null) {
      var uploadResult = await refresnce.putData(
          imageResult!.files.first.bytes!,
          SettableMetadata(contentType: 'image/png'));

      if (uploadResult.state == TaskState.success) {
        profileImgLink = await refresnce.getDownloadURL();
        var store = FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid);

        /*var result = await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
        if (result.data() != null) {
          profileDetails = UserModel.fromJson(result.data()!, result.id);

          // final desertRef = storageRef.child(profileDetails.imageUrl);
          // await desertRef.delete();
        }*/
// Delete the file
        //     let imageRef = storage.refFromURL(URL);
// imageRef.delete()
        await store.set({'imageUrl': profileImgLink}, SetOptions(merge: true));
        providerDispose();
        providerInit();
        await getUser();
        if (context.mounted) {
          ShowToastMessage.showToast(context, S.of(context).imgUpdate, 3000,
              ToastMessageStatus.success);
        }

        notifyListeners();
      }
    }

    OverlayLoadingProgress.stop();
  }

  Future<void> updateUser(BuildContext context) async {
    OverlayLoadingProgress.start();
//    if (newPasswordController?.text == rePasswordController?.text) {
    if (_globalKey?.currentState?.validate() ?? false) {
      _globalKey?.currentState?.save();
      //     if (profileDetails.password == oldPasswordController?.text) {

      try {
        // changeAuthPassword(profileDetails.email!, profileDetails.password!,
        //     newPasswordController?.text, context);
        updateProfile(nameController?.text, newPasswordController?.text);
        ShowToastMessage.showToast(
            context, S.of(context).saveData, 3000, ToastMessageStatus.success);
        providerDispose();
        await getUser();
        OverlayLoadingProgress.stop();
        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ProfileScreen(profileDetails: profileDetails)),
          );
          //  Navigator.pushNamed(context, AppRoutes.profileScreen);
        }
      } catch (e) {
        print(e.toString());
        OverlayLoadingProgress.stop();
      }
      //       } else {
      //   OverlayLoadingProgress.stop();
      //   ShowSnackbar.showSnackbar(context, S.of(context).errorOldPassword);
      // }
    } else {
      OverlayLoadingProgress.stop();
    }

    // } else {
    //   OverlayLoadingProgress.stop();
    //   ShowSnackbar.showSnackbar(context, S.of(context).errorRepassword);
    // }
  }

  updateProfile(String? name, String? password) async {
    var store = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    await store.set({
      'name': name,
      'password': password,
      'email': profileDetails.email,
      'imageUrl': profileDetails.imageUrl
    }, SetOptions(merge: true));
  }

  changeAuthPassword(String email, String password, String? newPassword,
      BuildContext context) async {
    final credential =
        EmailAuthProvider.credential(email: email, password: password);
    await FirebaseAuth.instance.currentUser!
        .reauthenticateWithCredential(credential)
        .then((value) {
      FirebaseAuth.instance.currentUser!.updatePassword(newPassword!);
    }).catchError((e) {
      print(e.toString());
    });
  }
}
