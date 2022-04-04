import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sendeaze/constants/assets-constants.dart';

class AddressCard extends StatelessWidget {
  final Function()? onArrowTap;
  final String? customer, address;
  const AddressCard({Key? key, this.onArrowTap, this.address, this.customer});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onArrowTap,
      child: Card(
        elevation: 5,
        child: Row(
          children: [
            Container(
              height: 60,
              width: Get.width * .84,
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AssetConstants.LOCATION_ICON),
                      SizedBox(width: 8),
                      Text(
                        customer ?? "",
                        style: Get.textTheme.button,
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: Get.width * .84,
                    height: Get.height * .03,
                    child: Text(
                      "       ${address ?? ""}",
                      style: Get.textTheme.caption,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: SvgPicture.asset(AssetConstants.ARROW_DOWN),
            ),
          ],
        ),
      ),
    );
  }
}
