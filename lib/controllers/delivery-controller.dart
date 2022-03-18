import 'package:get/get.dart';
import 'package:sendeaze/models/orders-list-response.dart';
import 'package:sendeaze/models/scanDataModel.dart';
import 'package:sendeaze/services/orders/orders-services.dart';
import 'package:sendeaze/utils/sharedPrefs.dart';
import 'package:sendeaze/widgets/app-widgets.dart';

class DeliveriesController extends GetxController {
  Rx<OrderListResponse> _deliveriesList = OrderListResponse().obs;
  OrderListResponse get deliveriesList => _deliveriesList.value;

  Future<void> getDeliveriesList() async {
    try {
      _deliveriesList.value = await OrderService().getDeliveries();
    } catch (ex) {
      AppWidgets.showSnackBar(ex.toString());
    }
  }

  RxList<Info> _infoList = <Info>[].obs;
  List<Info> get infoList => _infoList.toList();
  getInfoList(List<Info> list) {
    _infoList.value = list;
    update();
  }
}
