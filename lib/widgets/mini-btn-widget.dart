import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sendeaze/constants/color-constants.dart';

enum MiniButtonType { DELIVERED, ONGOING, CANCELED }

class MiniButtonWidget extends StatelessWidget {
  // final MiniButtonType buttonType;
  //
  // const MiniButtonWidget({this.buttonType = MiniButtonType.DELIVERED});
  final String? status;

  const MiniButtonWidget({Key? key, this.status}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
        decoration: BoxDecoration(
          color: getColor(),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          status ?? "",
//          getButtonText(this.buttonType),
          style: Get.textTheme.caption!.copyWith(color: AppColors.WHITE),
        ),
      ),
    );
  }

  getButtonText(MiniButtonType type) {
    if (type == MiniButtonType.DELIVERED)
      return "Delivered";
    else if (type == MiniButtonType.CANCELED)
      return "Not Delivered";
    else
      return "Ongoing";
  }

  getColor() {
    print(status);
    if (status == "Not Delivered") {
      return AppColors.RED.withOpacity(.8);
    } else if (status == "Picked") {
      return AppColors.CHIP_ORANGE.withOpacity(.8);
    } else if (status == "Pending") {
      return AppColors.CHIP_ORANGE.withOpacity(.8);
    } else if (status == "Not Available") {
      return AppColors.CHIP_GRAY.withOpacity(.8);
    } else if (status == "On The Way") {
      return AppColors.PRIMARY_BLUE.withOpacity(.8);
    } else {
      return AppColors.GREEN_LIGHT.withOpacity(.5);
    }
  }
}
