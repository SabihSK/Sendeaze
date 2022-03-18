import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sendeaze/constants/assets-constants.dart';
import 'package:sendeaze/constants/color-constants.dart';
import 'package:sendeaze/pages/home-page.dart';
import 'package:sendeaze/services/orders/orders-services.dart';
import 'package:sendeaze/services/user/user-service.dart';
import 'package:sendeaze/widgets/app-back-button.dart';
import 'package:sendeaze/widgets/app-loader.dart';
import 'package:sendeaze/widgets/app-widgets.dart';
import 'package:sendeaze/widgets/button-widget.dart';
import 'package:sendeaze/widgets/text-field-widget.dart';

import 'forgot-password-page.dart';

class LoginPage extends StatefulWidget {
  static String route = "/pages/login-page";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  String emailError = "";

  bool? emailValid = true, showLoader = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    getCurrentLocation();
    super.initState();
  }

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
              buildLogo()
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
                Column(
                  children: [
                    Text(
                      "welcome".tr,
                      style: Get.textTheme.headline5!.copyWith(
                        color: AppColors.PRIMARY_BLUE,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "login_to_your_account".tr,
                      style: Get.textTheme.caption,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextFieldWidget(
                      icon: AssetConstants.EMAIL_ICON,
                      hintText: "email_id".tr,
                      controller: _emailController,
                      errorText: emailError,
                      onChanged: (v) {
                        emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(v);
                        emailError = emailValid == false ? "Invalid email" : "";
                        setState(() {});
                      },
//                      suffixIcon: Icons.done_outlined,
                    ),
                    SizedBox(height: 10),
                    TextFieldWidget(
                      icon: AssetConstants.PASSWORD_ICON,
                      hintText: "password".tr,
                      controller: _passwordController,
                      isObsecure: true,
                    ),
                    SizedBox(
                      height: 30,
                      child: TextButton(
                        onPressed: () => Get.toNamed(ForgotPasswordPage.route),
                        child: Text(
                          "forgot_password".tr,
                          style: Get.textTheme.caption!
                              .copyWith(color: AppColors.PRIMARY_BLUE),
                        ),
                      ),
                    )
                  ],
                ),
                // SizedB
                ButtonWidget(
                  btnText: "login".tr,
                  onPressed: () {
                    if (_emailController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty) {
                      if (emailValid == false) {
                        AppWidgets.showSnackBar("Please enter valid email");
                      } else {
                        showLoader = true;
                        UserService()
                            .doLogin(
                                _emailController.text, _passwordController.text)
                            .then(
                                (value) => setState(() => showLoader = false));
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
//          AppBackButton(),
          if (showLoader!) Center(child: AppLoader())
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
