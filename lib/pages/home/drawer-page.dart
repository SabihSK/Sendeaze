import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sendeaze/constants/assets-constants.dart';
import 'package:sendeaze/constants/shared-pref-constant.dart';
import 'package:sendeaze/pages/delivery/delivery-history-page.dart';
import 'package:sendeaze/pages/home/profile.dart';
import 'package:sendeaze/pages/login-page.dart';
import 'package:sendeaze/pages/qr-code-page.dart';
import 'package:sendeaze/pages/report_issue_page.dart';
import 'package:sendeaze/services/common/shared-preference-service.dart';
import 'package:sendeaze/services/user/user-service.dart';
import 'package:sendeaze/utils/app-dummy-data.dart';
import 'package:sendeaze/widgets/drawer-list-tile.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  var name = "";
  String driverImage = "";
  bool isDataLoadel = false;

  Widget headerItem(BuildContext context) {
    return Container(
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: profileImage(),
        title: Text("welcome".tr + ", ${name}"),
      ),
      decoration: BoxDecoration(color: Colors.transparent),
    );
  }

  Widget profileImage() {
    return driverImage != ""
        ? Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(driverImage, scale: 1),
                fit: BoxFit.cover,
              ),
            ),
          )
        : Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                    "http://admin.sendeaze.com/public/assets/img/logo_3.png",
                    scale: 1),
                fit: BoxFit.cover,
              ),
            ),
          );
  }

  int currentSelectedIndex = 0;
  @override
  void initState() {
    getLocalData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * .6,
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerHeader(child: headerItem(context)),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: AppData.drawerListTileItemData.toList().length,
                itemBuilder: (context, int index) {
                  return DrawerListTile(
                    onTap: () => onTap(index),
                    isSelected: currentSelectedIndex == index,
                    title: AppData.drawerListTileItemData.toList()[index]
                        ['title'],
                    icon: AppData.drawerListTileItemData.toList()[index]
                        ['leading'],
                  );
                }),
            Spacer(),
            Divider(),
            DrawerListTile(
              onTap: () {
                Get.back();
                Get.to(() => ReportIssuePage());
              },
              title: "report_a_problem".tr,
              icon: AssetConstants.WARNING_ICON,
            ),
            DrawerListTile(
              onTap: () {
                UserService().logout().then((value) {
                  Get.offAllNamed(LoginPage.route);
                  SharedPref().removeAll();
                });
              },
              title: "logout".tr,
              icon: AssetConstants.LOGOUT_ICON,
            ),
          ],
        ),
      ),
    );
  }

  onTap(int index) {
    setState(() {
      currentSelectedIndex = index;
    });
    switch (index) {
      case 0:
        Get.back();
        break;
      case 1:
        gotoNextPage(EditProfileScreen.routeName);
        break;
      case 2:
        gotoNextPage(DeliveryHistoryPage.route);
        break;
      case 3:
        gotoNextPage(QRCodeScreen.routeName);
        break;
      default:
        {
          print('default case');
        }
        break;
    }
  }

  gotoNextPage(String route) {
    Get.back();
    Get.toNamed(route);
  }

  void getLocalData() async {
    name = await SharedPref().getDataFromLocal(SharedPrefConstants.NAME);
    driverImage = await SharedPref()
        .getDataFromLocal(SharedPrefConstants.USER_PROFILE_IMAGE);
    setState(() {});
  }
}
