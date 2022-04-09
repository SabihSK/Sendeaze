import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sendeaze/constants/assets-constants.dart';
import 'package:sendeaze/constants/color-constants.dart';
import 'package:sendeaze/models/orders-list-response.dart';
import 'package:sendeaze/widgets/mini-btn-widget.dart';

import 'app-divder.dart';

class OrderDetailCard extends StatelessWidget {
  final Function()? ontap;
  final OrderListData? data;
  const OrderDetailCard({this.ontap, this.data});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: ontap,
          child: Card(
            color: AppColors.WHITE,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AssetConstants.LOCATION_ICON),
                            SizedBox(width: 8),
                            Text(
                              data?.customerName ?? "",
                              style: Get.textTheme.button,
                            ),
                            Spacer(),
                            MiniButtonWidget(
                              status: data!.deliveryStatus,
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          "         ${data!.deliveryAddress}",
                          style: Get.textTheme.caption,
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            orderNumWidget(text: "Order #${data?.boxUniqueId}"),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  SvgPicture.asset(AssetConstants.ARROW_RIGHT),
                ],
              ),
            ),
          ),
        ),
        AppDivider()
      ],
    );
  }

  Row orderNumWidget(
      {String text = "Order #20255",
      String icon = AssetConstants.ORDER_ID_ICON}) {
    return Row(
      children: [
        SvgPicture.asset(icon),
        SizedBox(width: 5),
        Text(
          text,
          style: Get.textTheme.caption!
              .copyWith(color: AppColors.GREY, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
