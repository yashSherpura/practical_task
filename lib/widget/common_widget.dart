import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/color_utils.dart';
import '../utils/image_url.dart';

/// Common Text.
Widget textString(
    String title, dynamic size, Color color, FontWeight fontWeight,
    {textAlign}) {
  return Text(
    title,
    textAlign: textAlign,
    style: TextStyle(
        fontSize: size / Get.textScaleFactor,
        color: color,
        fontWeight: fontWeight),
  );
}

/// Login screens Common Button
Widget commonLoginButton(
    BuildContext context, String title, VoidCallback onTap) {
  var size = MediaQuery.of(context).size;
  return Material(
    borderRadius: BorderRadius.circular(10),
    elevation: 4.0,
    child: InkWell(
      onTap: onTap,
      child: Container(
        height: size.height * 0.09,
        width: size.width,
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: white),
            borderRadius: BorderRadius.circular(10),
            color: buttonColor),
        child: Center(
            child: textString(title, 20, black, FontWeight.w600)),
      ),
    ),
  );
}

/// Google sign in & Create new account Common Button
Widget createNewAccountCommonButton(
    BuildContext context, String title, VoidCallback onTap) {
  var size = MediaQuery.of(context).size;
  return InkWell(
    onTap: onTap,
    child: Container(
      height: size.height * 0.09,
      width: size.width,
      decoration: BoxDecoration(
        border: Border.all(
            width: 2, color: createNewAccountButtonColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
          child: textString(title, 20, createNewAccountTextColor,
              FontWeight.w600)),
    ),
  );
}

/// Common AppBar.
appBar(String title, context, bool flag, {Function()? backAction}) {
  return AppBar(
    backgroundColor: white,
    centerTitle: true,
    elevation: 0,
    leading: flag
        ? Padding(padding: const EdgeInsets.all(8.0),
      child: IconButton(
        onPressed: backAction,
        icon: Image.asset(backArrow,),
      ),
    ) : const SizedBox(),
    actions: [
      Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 10.0,),
          child: textString(title, 20, black, FontWeight.bold,),
        ),
      ),
    ],
  );
}