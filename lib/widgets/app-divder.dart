import 'package:flutter/material.dart';
import 'package:sendeaze/constants/color-constants.dart';

class AppDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(color: AppColors.GREY.withOpacity(.3));
  }
}