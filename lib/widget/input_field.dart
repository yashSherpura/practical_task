// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yash_sherpura_practical_task/utils/color_utils.dart';
import 'package:yash_sherpura_practical_task/widget/common_widget.dart';

class InputField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final int? maxLines,maxLength;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final bool? editable;
  final bool? autoFocus;
  final bool? isObscureText;
  final Widget? leftIcon,rightIcon;
  final TextInputAction? moveCurser;
  final String? titleText;
  final String? imageIcon;

  const InputField({
    Key? key,
    this.hintText,
    this.editable,
    this.onChanged,
    this.controller,
    this.validator,
    this.maxLines,
    this.keyboardType,
    this.maxLength,
    this.focusNode,this.leftIcon,this.rightIcon,this.moveCurser,this.autoFocus,
    this.titleText,
    this.imageIcon,
    this.isObscureText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2,color: autoFocus == true ? blueTextFieldBorderColor : textFieldBorderColor)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleText == null ? Container() :
          Padding(padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                imageIcon == null ? Container() :
                Image.asset(imageIcon.toString(),height: 10,width: 15,),
                const SizedBox(width: 5,),
                textString(titleText.toString(), 13, grey, FontWeight.w600),
              ],
            ) ,),
          TextFormField(
            controller: controller,
            maxLength:maxLength,
            maxLines: maxLines,
            keyboardType: keyboardType,
            enabled: editable,
            cursorColor: black,
            autofocus: autoFocus ?? false,
            focusNode: focusNode,
            onChanged: onChanged,
            obscureText: isObscureText ?? false,
            decoration: InputDecoration(
              border: InputBorder.none,
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              contentPadding:  const EdgeInsets.only(left: 30,right: 10,),
              counterText: "",
              hintText: hintText,
              suffix: rightIcon ,
              hintStyle: TextStyle(
                color:textFieldHintTextColor,
                fontSize: 16 / Get.textScaleFactor,
                fontWeight: FontWeight.w500,
              ),
            ),
            style: TextStyle(fontSize: 14 / Get.textScaleFactor,fontWeight: FontWeight.w400,color: black),
            textInputAction:  moveCurser ,
            validator:validator,
          ),
        ],
      ),
    );
  }
}
