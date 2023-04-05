// ignore_for_file: use_build_context_synchronously, avoid_print, unused_field, file_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:yash_sherpura_practical_task/utils/image_url.dart';
import 'package:yash_sherpura_practical_task/utils/text_title.dart';
import 'package:yash_sherpura_practical_task/view/registration_screen.dart';
import 'package:yash_sherpura_practical_task/view/forgot_password.dart';
import 'package:yash_sherpura_practical_task/widget/input_field.dart';

import '../utils/color_utils.dart';
import '../utils/constant.dart';
import '../widget/common_widget.dart';
import '../widget/pref_manager.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;
  bool handleEmailValidationError = false;
  bool handlePasswordValidationError = false;
  String emailValidationMessage = "";
  String passwordValidationMessage = "";
  bool isLoading = false;

  @override
  void initState() {
    passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
        return Future.value(true);
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            height: size.height,
            width: size.width,
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20,),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: textString(stringWelcomeBack, 25, black, FontWeight.w700, textAlign: TextAlign.center)),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                          child: textString(stringUseYourCredentialsLogAccount, 15, grey, FontWeight.w400, textAlign: TextAlign.center)),
                      const SizedBox(
                        height: 20,
                      ),
                      InputField(
                        imageIcon: emailAddressImage,
                        titleText: stringEmailAddress,
                        controller: emailController,
                        hintText: stringEmailAddress,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          if (emailController.text.isNotEmpty) {
                            setState(() {
                              handleEmailValidationError = false;
                            });
                            setState(() {
                              var regex = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                              if (value.isEmpty) {
                                setState(() {
                                  handleEmailValidationError = true;
                                  emailValidationMessage = fieldIsRequired;
                                });
                              } else if (value.contains(' ')) {
                                setState(() {
                                  handleEmailValidationError = true;
                                  emailValidationMessage = spaceNotAllow;
                                });
                              } else if (!regex.hasMatch(value)) {
                                setState(() {
                                  handleEmailValidationError = true;
                                  emailValidationMessage = 'Enter a Valid Email Address';
                                });
                              }
                            });
                          } else {
                            setState(() {
                              handleEmailValidationError = true;
                              emailValidationMessage = fieldIsRequired;
                            });
                          }
                        },
                      ),
                      handleEmailValidationError == true ? Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: textString(emailValidationMessage, 12, Colors.red, FontWeight.w400),) : Container(),

                      const SizedBox(
                        height: 20,
                      ),

                      InputField(
                        imageIcon: passwordImage,
                        titleText: stringPassword,
                        controller: passwordController,
                        hintText: stringPassword,
                        maxLines: 1,
                        keyboardType: TextInputType.visiblePassword,
                        isObscureText: !passwordVisible,
                        rightIcon: IconButton(
                          icon: Icon(
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
                        onChanged: (value) {
                          if (passwordController.text.isNotEmpty) {
                            setState(() {
                              handlePasswordValidationError = false;
                            });
                            setState(() {
                              if (value.isEmpty) {
                                setState(() {
                                  handlePasswordValidationError = true;
                                  passwordValidationMessage = fieldIsRequired;
                                });
                              } else if (value.length < 8) {
                                handlePasswordValidationError = true;
                                passwordValidationMessage = "Password must Minimum 8 Character";
                              } else if (value.startsWith(" ") || value.endsWith(" ")) {
                                setState(() {
                                  handlePasswordValidationError = true;
                                  passwordValidationMessage = spaceNotAllow;
                                });
                              }
                            });
                          } else {
                            setState(() {
                              handlePasswordValidationError = true;
                              passwordValidationMessage = fieldIsRequired;
                            });
                          }
                        },
                      ),
                      handlePasswordValidationError == true ? Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: textString(passwordValidationMessage, 12, Colors.red, FontWeight.w400),) : Container(),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  commonLoginButton(context, stringLogin, () {
                    handleLogin();
                  }),
                  const SizedBox(
                    height: 15,
                  ),
                  TextButton(
                      onPressed: () async {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()));
                      },
                      child: textString(stringForgotPassword, 15, forgotPasswordColor, FontWeight.w600)),

                  const SizedBox(
                    height: 15,
                  ),
                  createNewAccountCommonButton(context, stringCreateNewAccount, () async {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const RegistrationScreen()));
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Handle Login Button.
  handleLogin() async {
    if (emailController.text.isEmpty) {
      setState(() {
        handleEmailValidationError = true;
        emailValidationMessage = fieldIsRequired;
      });
    } else if (passwordController.text.isEmpty) {
      setState(() {
        handlePasswordValidationError = true;
        passwordValidationMessage = fieldIsRequired;
      });
    } else if(emailController.text != PreferenceUtils.getString(emailId).toString()){
      Fluttertoast.showToast(
        msg: "Invalid email address",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 3,
        backgroundColor: redColor,
        textColor: Colors.white,
        fontSize: 12 / Get.textScaleFactor,
      );
    } else if(passwordController.text != PreferenceUtils.getString(newPassword).toString()){
      Fluttertoast.showToast(
        msg: "Invalid password",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 3,
        backgroundColor: redColor,
        textColor: Colors.white,
        fontSize: 12 / Get.textScaleFactor,
      );
    } else if (handleEmailValidationError == false && handlePasswordValidationError == false) {
      Fluttertoast.showToast(
        msg: "Login Successfully",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 12 / Get.textScaleFactor,
      );
      emailController.clear();
      passwordController.clear();
    }
  }
}
