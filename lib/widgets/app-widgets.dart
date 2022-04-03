import 'package:get/get.dart';
import 'package:sendeaze/constants/color-constants.dart';

abstract class AppWidgets {
  static showSnackBar([message]) {
    Get.rawSnackbar(
      message: message ?? "Email and Password should not be empty!",
      backgroundColor: AppColors.PRIMARY,
      duration: Duration(seconds: 1),
    );
  }
}
