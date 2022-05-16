import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sendeaze/constants/assets-constants.dart';
import 'package:sendeaze/constants/color-constants.dart';
import 'package:sendeaze/constants/shared-pref-constant.dart';
import 'package:sendeaze/models/orders-list-response.dart';
import 'package:sendeaze/services/common/shared-preference-service.dart';
import 'package:sendeaze/widgets/mini-btn-widget.dart';

class DetailsBottomSheet extends StatelessWidget {
  var data;
  final driverName;

  DetailsBottomSheet({Key? key, this.data, required this.driverName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      margin: EdgeInsets.zero,
      child: Container(
        padding: EdgeInsets.all(12),
        // color: Colors.white,
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              height: 3.5,
              margin: EdgeInsets.symmetric(horizontal: Get.width * .4),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.GREY.withOpacity(.5),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.only(left: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: titleText("order".tr + " # ${data?.boxUniqueId}"),
                  ),
                  MiniButtonWidget(
                    status: data?.deliveryStatus,
                  )
                ],
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(AssetConstants.SPLASH_BACKGROUND),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: titleText(data?.customerName ?? ""),
              subtitle: Text(data?.deliveryAddress ?? ""),
            ),
            SizedBox(height: 25),
            titleText("order_details".tr),
            SizedBox(height: 15),
            Text(
              data?.deliveryDetails ?? "",
              style: Get.textTheme.bodyText2!.copyWith(color: AppColors.GREY),
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Text(
                //       "delivery_time".tr,
                //       style: Get.textTheme.button,
                //     ),
                //     SizedBox(
                //       height: 10,
                //     ),
                //     Text(
                //       DateFormat('dd-MM-yyyy hh:mm a').format(data?.pickedAt ??
                //           DateTime.now().add(Duration(hours: 1))),
                //       style:
                //           Get.textTheme.button!.copyWith(color: AppColors.GREY),
                //     )
                //   ],
                // ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "received_by".tr,
                      style: Get.textTheme.button,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      driverName,
                      style:
                          Get.textTheme.button!.copyWith(color: AppColors.GREY),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  Text titleText(String text) {
    return Text(text,
        style: Get.textTheme.subtitle1!.copyWith(fontWeight: FontWeight.w700));
  }
}
