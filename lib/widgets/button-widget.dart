import 'package:flutter/material.dart';
import 'package:sendeaze/constants/color-constants.dart';
import 'package:get/get.dart';

class ButtonWidget extends StatelessWidget {
  final Function()? onPressed;
  final String? btnText;
  final Color btnColor;
  final bool showLoader;

  const ButtonWidget(
      {Key? key,
      required this.onPressed,
      this.btnText,
      this.showLoader = false,
      this.btnColor = AppColors.PRIMARY})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: showLoader
            ? CircularProgressIndicator(backgroundColor: Colors.white)
            : btnText == "confirm".tr
                ? Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text(btnText ?? "next".tr),
                  )
                : Text(btnText ?? "next".tr),
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(0),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: MaterialStateProperty.all<Color>(btnColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
              side: BorderSide(color: btnColor),
            ),
          ),
        ),
      ),
    );
  }
}
