import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sendeaze/constants/assets-constants.dart';
import 'package:sendeaze/constants/color-constants.dart';

class DrawerListTile extends StatelessWidget {
  final String? title;
  final String? icon;
  final Function()? onTap;
  final bool isSelected;

  const DrawerListTile(
      {Key? key, this.title, this.icon, this.onTap, this.isSelected = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        decoration: isSelected == true
            ? BoxDecoration(color: AppColors.PRIMARY
                // gradient: LinearGradient(
                //     begin: Alignment.topLeft,
                //     end: Alignment.bottomRight,
                //     colors: [Colors.amber, Colors.limeAccent]),
                )
            : BoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              SizedBox(width: 12),
              SizedBox(
                  width: 20,
                  height: 25,
                  child: SvgPicture.asset(
                    icon ?? AssetConstants.HOME_ICON,
                    color: isSelected ? AppColors.WHITE : null,
                    height: 25,
                  )),
              SizedBox(width: 12),
              Text(
                title ?? "home".tr,
                style: Get.textTheme.caption!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isSelected ? AppColors.WHITE : null,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
