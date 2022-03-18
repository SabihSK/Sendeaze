import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:sendeaze/constants/color-constants.dart';

class AppBackButton extends StatelessWidget {
  final bool isTransparent;
  final Function()? onPressed;
  final double? marginArround;
  const AppBackButton(
      {this.isTransparent = false, this.onPressed, this.marginArround});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: EdgeInsets.all(marginArround ?? 5.0),
          child: IconButton(
              onPressed: onPressed ??
                  () => SchedulerBinding.instance!.addPostFrameCallback((_) {
                        Get.back();
                      }),
              icon: Container(
                  padding: EdgeInsets.only(left: 6),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isTransparent
                        ? AppColors.BACKGROUND_LIGHT
                        : AppColors.WHITE,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: AppColors.PRIMARY,
                  ))),
        ),
      ),
    );
  }
}
