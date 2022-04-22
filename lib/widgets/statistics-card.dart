import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sendeaze/constants/assets-constants.dart';
import 'package:sendeaze/constants/color-constants.dart';
import 'package:sendeaze/models/profile_model.dart';
import 'package:sendeaze/services/user/user-service.dart';

class StatisticsCard extends StatelessWidget {
  late final Future<ProfileModel>? myProfile = UserService().getProfile();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ProfileModel>(
        future: myProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: SizedBox());
          }
          var statics = snapshot.data?.data?.stats ??
              Stats(
                  totalOrdersDeliveredToday: 0,
                  totalRatings: 0,
                  timeSpentMinutesToday: "0");

          return Card(
            elevation: 2,
            color: AppColors.WHITE,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AssetConstants.INSIGHT_ICON),
                      SizedBox(width: 15),
                      Text(
                        "insights".tr,
                        style: Get.textTheme.button,
                      )
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildStatData(
                          val: statics.totalOrdersDeliveredToday!.toInt()),
                      buildStatData(
                          title: "rating".tr,
                          icon: AssetConstants.STAR_ICON,
                          val: statics.totalRatings!.toInt()),
                      buildStatData(
                          title: "total_time".tr,
                          icon: AssetConstants.TIME_ICON,
                          val: statics.timeSpentMinutesToday!),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Column buildStatData(
      {String title = "Total Orders",
      required val,
      String icon = AssetConstants.VAN_ICON}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(icon),
            SizedBox(width: 8),
            Text(
              title,
              style: Get.textTheme.caption,
            )
          ],
        ),
        SizedBox(height: 5),
        Text(
          "$val",
          style: Get.textTheme.subtitle1!.copyWith(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
