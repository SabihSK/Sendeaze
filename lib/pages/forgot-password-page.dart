import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sendeaze/constants/assets-constants.dart';
import 'package:sendeaze/constants/color-constants.dart';
import 'package:sendeaze/pages/login-page.dart';
import 'package:sendeaze/services/user/user-service.dart';
import 'package:sendeaze/widgets/app-back-button.dart';
import 'package:sendeaze/widgets/app-loader.dart';
import 'package:sendeaze/widgets/app-widgets.dart';
import 'package:sendeaze/widgets/button-widget.dart';
import 'package:sendeaze/widgets/text-field-widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  static String route = "/pages/forgot-password-page";

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController _emailController = TextEditingController();

  bool showLoader = false;
  bool emailValid = true;

  String emailError = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Stack(
            children: [
              Image.asset(
                AssetConstants.PAGE_BACKGROUND,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              buildLogo(),
            ],
          ),
          Container(
            height: Get.height * .5,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
                color: AppColors.WHITE,
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "reset_password".tr,
                  style: Get.textTheme.headline5!.copyWith(
                    color: AppColors.PRIMARY_BLUE,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                TextFieldWidget(
                  icon: AssetConstants.EMAIL_ICON,
                  hintText: "email_id".tr,
                  errorText: emailError,
                  controller: _emailController,
                  onChanged: (v) {
                    emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(v);
                    emailError = emailValid == false ? "Invalid email" : "";
                    setState(() {});
                  },
                ),
                ButtonWidget(
                  btnText: "submit".tr,
                  onPressed: () {
                    if (_emailController.text.isNotEmpty) {
                      if (emailValid == false) {
                        AppWidgets.showSnackBar("Please enter valid email");
                      } else {
                        showLoader = true;
                        UserService()
                            .forgotPassword(_emailController.text)
                            .then((value) {
                          setState(() => showLoader = false);
                          if (value.message != null)
                            Get.offAll(() => LoginPage());
                        });
                      }
                    } else {
                      AppWidgets.showSnackBar();
                    }
                    setState(() {});
                  },
                )
              ],
            ),
          ),
          AppBackButton(),
          if (showLoader) Center(child: AppLoader())
        ],
      ),
    );
  }

  Container buildLogo() {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AssetConstants.LOGO,
            fit: BoxFit.fill,
          ),
          SizedBox(),
          SizedBox(),
          SizedBox(),
        ],
      ),
    );
  }
}
