import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/consts/toastStatus.dart';
import 'package:flutter/material.dart';

abstract class ShowToastMessage {
  static void showToast(BuildContext context, String title,int time,
      ToastMessageStatus toastMessageStatus) {
    VxToast.show(context,
        msg: title,
        showTime: time,
        textColor:  ColorsApp.whiteColor
        ,bgColor: toastMessageStatus == ToastMessageStatus.success
            ? ColorsApp.PKColor
            : toastMessageStatus == ToastMessageStatus.failed
                ? ColorsApp.red
                : ColorsApp.golden     
   );
  }
}
