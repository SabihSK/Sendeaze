import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sendeaze/constants/assets-constants.dart';
import 'package:sendeaze/constants/color-constants.dart';
import 'package:sendeaze/constants/shared-pref-constant.dart';
import 'package:sendeaze/pages/login-page.dart';
import 'package:sendeaze/services/common/shared-preference-service.dart';
import 'package:sendeaze/widgets/button-widget.dart';

class LanguageSelectorPage extends StatefulWidget {
  static String route = "/pages/language-selector-page";

  @override
  _LanguageSelectorPageState createState() => _LanguageSelectorPageState();
}

class _LanguageSelectorPageState extends State<LanguageSelectorPage> {
  var segmentedControlValue;
  @override
  void initState() {
    segmentedControlValue = 0;
    SharedPref().setStringToLocal(
        SharedPrefConstants.CURRENT_LANGUAGE, segmentedControlValue.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            height: Get.height * .4,
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
                  "choose_language".tr,
                  style: Get.textTheme.headline6!.copyWith(
                      color: AppColors.PRIMARY_BLUE,
                      fontWeight: FontWeight.w500),
                ),
                segmentedControl(),
                ButtonWidget(
                  btnText: "next".tr,
                  onPressed: () => Get.toNamed(LoginPage.route),
                )
              ],
            ),
          ),
//          AppBackButton(),
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
        ],
      ),
    );
  }

  Widget segmentedControl() {
    return Container(
      width: double.infinity,
      child: CupertinoSlidingSegmentedControl(
          groupValue: segmentedControlValue,
          thumbColor: AppColors.PRIMARY_BLUE,
          backgroundColor: AppColors.BACKGROUND_LIGHT,
          children: <int, Widget>{
            0: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'English',
                style: TextStyle(
                    color: segmentedControlValue == 0
                        ? AppColors.WHITE
                        : AppColors.PRIMARY),
              ),
            ),
            1: Text(
              'Arabic',
              style: TextStyle(
                  color: segmentedControlValue == 1
                      ? AppColors.WHITE
                      : AppColors.PRIMARY),
            ),
          },
          onValueChanged: (value) {
            setState(() {
              segmentedControlValue = value;
              print("value $value");
//              Get.updateLocale(Locale("bn","BD" ));
            });
          }),
    );
  }
}
