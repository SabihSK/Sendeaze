import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sendeaze/constants/assets-constants.dart';
import 'package:sendeaze/constants/shared-pref-constant.dart';
import 'package:sendeaze/pages/home-page.dart';
import 'package:sendeaze/pages/language-selector-page.dart';
import 'package:sendeaze/pages/login-page.dart';
import 'package:sendeaze/services/common/shared-preference-service.dart';
import 'package:sendeaze/services/orders/orders-services.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // var brightness = SchedulerBinding.instance!.window.platformBrightness;
  @override
  void initState() {
    initmyState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Image.asset(
        AssetConstants.SPLASH_BACKGROUND,
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }

  void initmyState() async {
    bool rememeber = await SharedPref().getBoolFromLocal("rememberMe");
    dynamic language = await SharedPref()
            .getDataFromLocal(SharedPrefConstants.CURRENT_LANGUAGE) ??
        null;
    Timer(Duration(seconds: 3), () {
      if (language == null || language=='') {
        Get.offAllNamed(LanguageSelectorPage.route);
      } else if (rememeber) {
        Get.offAndToNamed(HomePage.route);
      } else {
        Get.offAllNamed(LoginPage.route);
      }
      // Get.offAllNamed(LanguageSelectorPage.route);
    });
    getCurrentLocation();
  }
}
