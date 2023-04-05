// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/color_utils.dart';

class SimpleTextInputField extends StatelessWidget {
  final String? hintText;  final   TextEditingController? controller;

  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final int? maxLines,maxLength;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final bool? editable;
  final bool? autoFocus;
  final bool? isObscureText;
  final bool? enableField;
  final Widget? leftIcon,rightIcon;
  final TextInputAction? moveCurser;

  const SimpleTextInputField({
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
    this.isObscureText,
    this.enableField
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
      enabled: enableField ?? true,
      border: OutlineInputBorder(
        borderSide: const BorderSide(
          width: 2, color: textFieldBorderColor,
        ),
        borderRadius: BorderRadius.circular(10),//<-- SEE HERE
      ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 2, color: textFieldBorderColor,
          ),
          borderRadius: BorderRadius.circular(10),//<-- SEE HERE
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              width: 2, color: textFieldBorderColor,
          ),
          borderRadius: BorderRadius.circular(10),//<-- SEE HERE
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 2, color: redColor,
          ),
          borderRadius: BorderRadius.circular(10),//<-- SEE HERE
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 2, color: blueTextFieldBorderColor,
          ),
          borderRadius: BorderRadius.circular(10),//<-- SEE HERE
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 2, color: redColor,
          ),
          borderRadius: BorderRadius.circular(10),//<-- SEE HERE
        ),
        contentPadding:  const EdgeInsets.only(left: 10,right: 10,bottom: 10),
        counterText: "",
        hintText: hintText,
        suffixIcon: rightIcon ,
        hintStyle: TextStyle(
          color:textFieldHintTextColor,
          fontSize: 16 / Get.textScaleFactor,
          fontWeight: FontWeight.w500,
        ),
      ),
      style: TextStyle(fontSize: 14 / Get.textScaleFactor,fontWeight: FontWeight.w400, color: black),
      textInputAction:  moveCurser ,
      validator:validator,
    );
  }



}
