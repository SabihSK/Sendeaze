import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sendeaze/constants/assets-constants.dart';
import 'package:sendeaze/constants/color-constants.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText, errorText;
  final String icon;
  final String? initialValue;
  final Color iconColor;
  final Color backgroundColor;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final bool isObsecure;
  final IconData? suffixIcon;

  final suffixColor;

  final TextInputType keyboradType;

  final enabled;

  const TextFieldWidget(
      {Key? key,
      this.initialValue,
      this.enabled = true,
      this.hintText = "Hint",
      this.icon = AssetConstants.EMAIL_ICON,
      this.isObsecure = false,
      this.iconColor = AppColors.PRIMARY_BLUE,
      this.backgroundColor = AppColors.BACKGROUND_LIGHT,
      this.onChanged,
      this.controller,
      this.suffixIcon,
      this.errorText = "",
      this.suffixColor,
      this.keyboradType = TextInputType.emailAddress})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 5),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(36),
          ),
          child: TextFormField(
            focusNode: FocusNode(),
            enabled: enabled,
            controller: controller,
            onChanged: onChanged,
            cursorColor: iconColor,
            initialValue: initialValue,
            obscureText: isObsecure,
            keyboardType: keyboradType,
            decoration: InputDecoration(
              icon: SvgPicture.asset(icon),
              suffix: Icon(
                suffixIcon,
                color: suffixColor,
              ),
              contentPadding: EdgeInsets.only(bottom: 8),
              hintText: hintText,
              hintStyle: TextStyle(color: iconColor, fontSize: 14),
              border: InputBorder.none,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            errorText,
            style: Get.textTheme.caption!.copyWith(color: AppColors.RED),
          ),
        )
      ],
    );
  }
}
