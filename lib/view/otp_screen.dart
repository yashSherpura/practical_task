// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:yash_sherpura_practical_task/view/forgot_password.dart';
import 'package:yash_sherpura_practical_task/view/password_forgot_successfully_screen.dart';

import '../utils/color_utils.dart';
import '../utils/constant.dart';
import '../utils/text_title.dart';
import '../widget/common_widget.dart';
import '../widget/pref_manager.dart';

class OtpScreen extends StatefulWidget {
  String? newPassword;
  OtpScreen({Key? key, this.newPassword}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  TextEditingController firstTextController  = TextEditingController();
  TextEditingController secondTextController  = TextEditingController();
  TextEditingController thirdTextController  = TextEditingController();
  TextEditingController fourthTextController  = TextEditingController();
  FocusNode firstTextFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      FocusScope.of(context).requestFocus();
    });
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        backAction();
        return Future.value(true);
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: appBar(
          'Verify Otp',
          context,
          true,
          backAction: () {
            backAction();
          },
        ),
        body: SafeArea(
          child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25,right: 25,top: 25),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(enterOtp,
                            style: TextStyle(
                                color: grey,
                                fontSize: 16 / Get.textScaleFactor,
                                fontWeight: FontWeight.w700,),),
                      ),
                      const SizedBox(height: 13,),
                      Row(
                        children: [
                          Flexible(
                              child: Container(
                                height: size.height/9 - 13,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white,
                                    boxShadow: [BoxShadow(
                                        offset: const Offset(0.0, 2.0),
                                        color: grey.withOpacity(0.3),
                                        blurRadius: 5,
                                        spreadRadius: 0.1
                                    )]
                                ),
                                margin: const EdgeInsets.all(5),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: OtpEditText(
                                      textController: firstTextController,
                                      focusNode: firstTextFocusNode,
                                      editable: true,
                                      onChanged: (value){
                                        firstTextController.text.isNotEmpty ?
                                        FocusScope.of(context).nextFocus() :
                                        FocusScope.of(context).unfocus();
                                      },
                                    )
                                ),
                              )),
                          const SizedBox(width: 22,),
                          Flexible(
                              child: Container(
                                height: size.height/9 - 13,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white,
                                    boxShadow: [BoxShadow(
                                        offset: const Offset(0.0, 2.0),
                                        color: grey.withOpacity(0.3),
                                        blurRadius: 5,
                                        spreadRadius: 0.1
                                    )]
                                ),
                                margin: const EdgeInsets.all(5),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: OtpEditText(
                                      textController: secondTextController,
                                      editable: true,
                                      onChanged: (value){
                                        secondTextController.text.isNotEmpty ?
                                        FocusScope.of(context).nextFocus() :
                                        FocusScope.of(context).previousFocus();
                                      },
                                    )
                                ),
                              )),
                          const SizedBox(width: 22,),
                          Flexible(
                              child: Container(
                                height: size.height/9 - 13,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white,
                                    boxShadow: [BoxShadow(
                                        offset: const Offset(0.0, 2.0),
                                        color: grey.withOpacity(0.3),
                                        blurRadius: 5,
                                        spreadRadius: 0.1
                                    )]
                                ),
                                margin: const EdgeInsets.all(5),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: OtpEditText(
                                      textController: thirdTextController,
                                      editable: true,
                                      onChanged: (value){
                                        thirdTextController.text.isNotEmpty ?
                                        FocusScope.of(context).nextFocus() :
                                        FocusScope.of(context).previousFocus();
                                      },
                                    )
                                ),
                              )),
                          const SizedBox(width: 22,),
                          Flexible(
                              child: Container(
                                height: size.height/9 - 13,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white,
                                    boxShadow: [BoxShadow(
                                        offset: const Offset(0.0, 2.0),
                                        color: grey.withOpacity(0.3),
                                        blurRadius: 5,
                                        spreadRadius: 0.1
                                    )]
                                ),
                                margin: const EdgeInsets.all(5),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: OtpEditText(
                                      textController: fourthTextController,
                                      editable: true,
                                      onChanged: (value){
                                        fourthTextController.text.isNotEmpty ?
                                        FocusScope.of(context).unfocus() :
                                        FocusScope.of(context).previousFocus();
                                      },
                                    )
                                ),
                              )),
                        ],
                      ),
                      const Spacer(),
                      resendText(context),
                      const SizedBox(height: 29,),
                      commonLoginButton(context, submitOtp, () async {
                        if(firstTextController.text.isEmpty || secondTextController.text.isEmpty || thirdTextController.text.isEmpty || fourthTextController.text.isEmpty){
                          Fluttertoast.showToast(
                            msg: "Enter otp",
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 3,
                            backgroundColor: redColor,
                            textColor: Colors.white,
                            fontSize: 12 / Get.textScaleFactor,
                          );
                        }else{
                          PreferenceUtils.setString(newPassword, widget.newPassword.toString());
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const PasswordForgotSuccessfullyScreen(),),);
                        }
                      }),
                      const SizedBox(height: 15,),
                    ],
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }

  Widget resendText(BuildContext context) {
    return TextButton(
      onPressed: (){},
      child: Text(
        resendOtp,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
            color: forgotPasswordColor,
            fontWeight: FontWeight.w700,
            fontSize: 16 / Get.textScaleFactor,),
      ),
    );
  }

  /// Navigation Back Action.
  backAction() async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ForgotPasswordScreen(),
      ),
    );
  }

}

class OtpEditText extends StatelessWidget {
  TextEditingController? textController;
  final ValueChanged<String>? onChanged;
  final bool? editable;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final Function? onEditingComplete;
  OtpEditText({Key? key, this.textController,this.onChanged,this.editable,
    this.focusNode,this.textInputAction,this.onEditingComplete}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      maxLength: 1,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      cursorColor: Colors.transparent,
      autofocus: true,
      onEditingComplete:()=> onEditingComplete,
      onChanged: onChanged,
      showCursor: false,
      readOnly: false,
      enabled: editable,
      focusNode: focusNode,
      textInputAction: textInputAction,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
        filled: true,
        fillColor: white,
        hintText: '*',
        counterText: "",
        isDense: true,
        border: InputBorder.none,
        hintStyle: TextStyle(fontWeight: FontWeight.w400,
            fontSize: 19 / Get.textScaleFactor),
      ),
      style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 19 / Get.textScaleFactor),
    );
  }
}
