// ignore_for_file: use_build_context_synchronously, avoid_print, file_names
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:yash_sherpura_practical_task/view/login_screen.dart';
import 'package:yash_sherpura_practical_task/widget/pref_manager.dart';

import '../utils/color_utils.dart';
import '../utils/constant.dart';
import '../utils/text_title.dart';
import '../widget/common_widget.dart';
import '../widget/regx_validation.dart';
import '../widget/simple_text_input_field.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  bool isPrivacyPolicyChecked = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  var pushToken = '';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        await backAction();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: appBar(
          'Registration',
          context,
          true,
          backAction: () async {
            await backAction();
          },
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Column(
                children: [
                  Form(
                    key: formKey,
                    onChanged: () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          autoValidateMode = AutovalidateMode.disabled;
                        });
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Padding(
                              padding:
                              const EdgeInsets.only(left: 15, right: 15),
                              child: textString(
                                  stringFillBelowInformationCreateAccount,
                                  15,
                                  grey,
                                  FontWeight.w400,
                                  textAlign: TextAlign.center),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        SimpleTextInputField(
                          controller: fullNameController,
                          hintText: stringFullName,
                          keyboardType: TextInputType.text,
                          validator: (val) => validateNameString(val!),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SimpleTextInputField(
                          controller: emailController,
                          hintText: stringEmailID,
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) => validateEmail(val!),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SimpleTextInputField(
                          controller: passwordController,
                          hintText: stringPassword,
                          maxLines: 1,
                          keyboardType: TextInputType.visiblePassword,
                          isObscureText: !passwordVisible,
                          rightIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: black,
                              size: 18,
                            ),
                            onPressed: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return fieldIsRequired;
                            } else if (value.length < 8) {
                              return "Password must Minimum 8 Character";
                            } else if (value.startsWith(" ") ||
                                value.endsWith(" ")) {
                              return spaceNotAllow;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SimpleTextInputField(
                          controller: confirmPasswordController,
                          hintText: stringConfirmPassword,
                          maxLines: 1,
                          keyboardType: TextInputType.visiblePassword,
                          isObscureText: !confirmPasswordVisible,
                          rightIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              confirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: black,
                              size: 18,
                            ),
                            onPressed: () {
                              setState(() {
                                confirmPasswordVisible =
                                !confirmPasswordVisible;
                              });
                            },
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return fieldIsRequired;
                            } else if (value.length < 8) {
                              return "Password must Minimum 8 Character";
                            } else if (passwordController.text !=
                                confirmPasswordController.text) {
                              return "Password and Confirm Password doesn't Match.";
                            } else if (value.startsWith(" ") ||
                                value.endsWith(" ")) {
                              return spaceNotAllow;
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        materialTapTargetSize:
                        MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                        checkColor: Colors.white,
                        fillColor:
                        MaterialStateProperty.resolveWith(getColor),
                        value: isPrivacyPolicyChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isPrivacyPolicyChecked = value!;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: RichText(
                            text: TextSpan(
                                text: stringIAmAgree,
                                style: TextStyle(
                                    fontSize: 13 / Get.textScaleFactor,
                                    color: grey,
                                    fontWeight: FontWeight.w700),
                                children: [
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                      },
                                    text: stringPrivacyPolicy,
                                    style: TextStyle(
                                        fontSize: 13 / Get.textScaleFactor,
                                        color: forgotPasswordColor,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  TextSpan(
                                    text: stringAnd,
                                    style: TextStyle(

                                        fontSize: 13 / Get.textScaleFactor,
                                        color: grey,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                      },
                                    text: stringTermsOfService,
                                    style: TextStyle(
                                        fontSize: 13 / Get.textScaleFactor,
                                        color: forgotPasswordColor,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ])),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  commonLoginButton(context, stringCreateMyAccount, () {
                    handleCreateMyAccount(fullNameController.text,emailController.text,passwordController.text);
                  }),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Container(
                          width: size.width,
                          height: 2,
                          color: dividerColor,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      textString("OR", 12, grey, FontWeight.w600),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          width: size.width,
                          height: 2,
                          color: dividerColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                      onPressed: () {
                        backAction();
                      },
                      child: textString(stringHaveAnAccount, 15,
                          forgotPasswordColor, FontWeight.w600)),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Terms and condition Checkbox color method.
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return const Color(0xff5B5B5B);
  }

  /// Navigation Back Action.
  backAction() async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
    }

  /// Handle Create My Account Button.
  handleCreateMyAccount(String name, String email, String password) async {
    if (formKey.currentState!.validate()) {

      if (isPrivacyPolicyChecked == true) {
        PreferenceUtils.setString(fullName, name);
        PreferenceUtils.setString(emailId, email);
        PreferenceUtils.setString(newPassword, password);
        backAction();
      } else {
        Fluttertoast.showToast(
          msg: "Please Agree with the Privacy Policy",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: redColor,
          textColor: Colors.white,
          fontSize: 12 / Get.textScaleFactor,
        );
      }
    }
  }

}
