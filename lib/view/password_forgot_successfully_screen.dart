// ignore_for_file: use_build_context_synchronously, file_names
import 'package:flutter/material.dart';

import '../utils/color_utils.dart';
import '../utils/image_url.dart';
import '../utils/text_title.dart';
import '../widget/common_widget.dart';
import 'login_screen.dart';

class PasswordForgotSuccessfullyScreen extends StatefulWidget {
  const PasswordForgotSuccessfullyScreen({Key? key}) : super(key: key);

  @override
  State<PasswordForgotSuccessfullyScreen> createState() => _PasswordForgotSuccessfullyScreenState();
}

class _PasswordForgotSuccessfullyScreenState extends State<PasswordForgotSuccessfullyScreen> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await backAction();
        return Future.value(true);
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 100),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: textString(stringSuccessfullyResetThePassword,
                              25, black, FontWeight.w700,
                              textAlign: TextAlign.center)),
                      const SizedBox(
                        height: 50,
                      ),
                      Center(
                          child: Image.asset(
                        resetPasswordImage,
                        height: 184,
                        width: 184,
                      )),
                      const SizedBox(
                        height: 70,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  commonLoginButton(context, stringBackToLogin, () async {
                    await backAction();
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
}
