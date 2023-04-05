// ignore_for_file: use_build_context_synchronously, file_names
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yash_sherpura_practical_task/view/otp_screen.dart';

import '../utils/color_utils.dart';
import '../utils/constant.dart';
import '../utils/image_url.dart';
import '../utils/text_title.dart';
import '../widget/common_widget.dart';
import '../widget/input_field.dart';
import '../widget/pref_manager.dart';
import 'login_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;
  bool newPasswordVisible = false;
  bool handlePasswordValidationError = false;
  TextEditingController newPasswordController = TextEditingController();
  bool handleNewPasswordValidationError = false;
  String newPasswordValidationMessage = "";
  String passwordValidationMessage = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await backAction();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: appBar(
          'Forgot Password',
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
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: textString(
                              stringPleaseEnterYourValidCurrentPasswordChangeYourPassword,
                              15,
                              grey,
                              FontWeight.w400,
                              textAlign: TextAlign.center)),
                      const SizedBox(
                        height: 20,
                      ),
                      InputField(
                        imageIcon: passwordImage,
                        titleText: stringCurrentPassword,
                        controller: passwordController,
                        hintText: stringCurrentPassword,
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
                              } else if(passwordController.text != PreferenceUtils.getString(newPassword).toString()){
                                handlePasswordValidationError = true;
                                passwordValidationMessage = "Invalid password";
                              }else if (value.startsWith(" ") || value.endsWith(" ")) {
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
                      handlePasswordValidationError == true
                          ? Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: textString(passwordValidationMessage, 12,
                            Colors.red, FontWeight.w400),
                      ) : Container(),

                      const SizedBox(
                        height: 20,
                      ),

                      InputField(
                        imageIcon: passwordImage,
                        titleText: stringNewPassword,
                        controller: newPasswordController,
                        hintText: stringNewPassword,
                        maxLines: 1,
                        keyboardType: TextInputType.visiblePassword,
                        isObscureText: !newPasswordVisible,
                        rightIcon: IconButton(
                          icon: Icon(
                            newPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: black,
                            size: 18,
                          ),
                          onPressed: () {
                            setState(() {
                              newPasswordVisible = !newPasswordVisible;
                            });
                          },
                        ),
                        onChanged: (value) {
                          if (newPasswordController.text.isNotEmpty) {
                            setState(() {
                              handleNewPasswordValidationError = false;
                            });
                            setState(() {
                              if (value.isEmpty) {
                                setState(() {
                                  handleNewPasswordValidationError = true;
                                  newPasswordValidationMessage = fieldIsRequired;
                                });
                              } else if (value.length < 8) {
                                handleNewPasswordValidationError = true;
                                newPasswordValidationMessage = "Password must Minimum 8 Character";
                              } else if (value.startsWith(" ") || value.endsWith(" ")) {
                                setState(() {
                                  handleNewPasswordValidationError = true;
                                  newPasswordValidationMessage = spaceNotAllow;
                                });
                              }
                            });
                          } else {
                            setState(() {
                              handleNewPasswordValidationError = true;
                              newPasswordValidationMessage = fieldIsRequired;
                            });
                          }
                        },
                      ),
                      handleNewPasswordValidationError == true ? Padding(padding: const EdgeInsets.only(left: 5.0),
                              child: textString(newPasswordValidationMessage, 12, Colors.red, FontWeight.w400),) : Container(),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  commonLoginButton(context, stringChangePassword, () async {
                    handleChangePassword(newPasswordController.text);
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Navigation Back Action.
  backAction() async {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }

    /// Handle Login Button.
    handleChangePassword(String changeNewPassword) async {
      if (passwordController.text.isEmpty) {
        setState(() {
          handlePasswordValidationError = true;
          passwordValidationMessage = fieldIsRequired;
        });
      } else if (newPasswordController.text.isEmpty) {
        setState(() {
          handleNewPasswordValidationError = true;
          newPasswordValidationMessage = fieldIsRequired;
        });
      } else if (handlePasswordValidationError == false && handleNewPasswordValidationError == false) {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => OtpScreen(
          newPassword: changeNewPassword,
        )));
      }
    }
}
