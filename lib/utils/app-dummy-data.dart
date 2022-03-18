import 'package:sendeaze/constants/assets-constants.dart';
import 'package:get/get.dart';

abstract class AppData {
  static List<Map<String, dynamic>> drawerListTileItemData = [
    {
      'title': "home".tr,
      'leading': AssetConstants.HOME_ICON,
    },
    {
      'title': "profile".tr,
      'leading': AssetConstants.PROFILE_ICON,
    },
    {
      'title': "delivery_history".tr,
      'leading': AssetConstants.DELIVERY,
    },
    {
      'title': "pickup_orders".tr,
      'leading': AssetConstants.PICKUP_ORDER_ICON,
    },
  ];
}
