import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_svg/svg.dart';
import 'package:sendeaze/constants/assets-constants.dart';
import 'package:sendeaze/constants/color-constants.dart';
import 'package:sendeaze/controllers/delivery-controller.dart';
import 'package:sendeaze/pages/home/drawer-page.dart';
import 'package:sendeaze/pages/home/profile.dart';
import 'package:sendeaze/widgets/app-widgets.dart';

import '../services/orders/orders-services.dart';
import 'delivery/ongoing-delivery-page.dart';
import 'home/home-tab.dart';

class HomePage extends StatefulWidget {
  static String route = "/pages/home-page";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIdx = 0;
  DeliveriesController _deliveriesController = DeliveriesController();
  List<Widget> _widgetOptions = <Widget>[
    HomeTab(),
    EditProfileScreen(
      isOpenFromTab: true,
    ),
  ];
  @override
  void initState() {
    _deliveriesController.getDeliveriesList();
    getData();
    super.initState();
  }

  var deliveryList;

  getData() async {
    // await OrderService().getDeliveries();
    // deliveryList = OrderService().deliveriesData;

    Timer(Duration(seconds: 5), () {
      _deliveriesController.getDeliveriesList();
      print("object");
      // setState(() {});
    });
    // ignore: await_only_futures
    // if (await _deliveriesController.deliveriesList.data != null) {
    //   setState(() async {
    //     // ignore: await_only_futures
    if (_deliveriesController.deliveriesList.data != null) {
      print("hasData");
    }
    deliveryList = _deliveriesController.deliveriesList.data;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    // if (Get.mediaQuery.viewInsets.bottom == 0.0) {
    //   setState(() {});
    // }
    // OrderService().getDeliveries() = _deliveriesController.deliveriesList.data;
    _deliveriesController.getDeliveriesList();
    deliveryList = _deliveriesController.deliveriesList.data;
    return Scaffold(
      drawer: AppDrawer(),
      body: Center(child: _widgetOptions.elementAt(_selectedIdx)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _deliveriesController.getDeliveriesList();
            deliveryList = _deliveriesController.deliveriesList.data;
            // setState(() {});
            print(deliveryList);
            if (deliveryList != null && deliveryList.isNotEmpty) {
              if (deliveryList.any((e) =>
                  e.deliveryStatus != "Delivered" &&
                  e.deliveryStatus != "Not Delivered" &&
                  e.deliveryStatus != "Pending")) {
                Get.to(
                  () => OnGoingDeliveryPage(
                    data: deliveryList.firstWhere(
                      (e) =>
                          e.deliveryStatus != "Delivered" &&
                          e.deliveryStatus != "Not Delivered" &&
                          e.deliveryStatus != "Pending",
                    ),
                  ),
                );
              } else {
                AppWidgets.showSnackBar("No delivery found to deliver!!!");
              }
            } else {
              AppWidgets.showSnackBar("No delivery found to deliver!!!");
            }
          });
        },
        heroTag: UniqueKey(),
        child: SvgPicture.asset(
          AssetConstants.VAN_ICON,
          color: AppColors.WHITE,
          height: 27,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        child: BottomNavigationBar(
            backgroundColor: AppColors.WHITE,
            elevation: 8,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            currentIndex: _selectedIdx,
            selectedItemColor: AppColors.PRIMARY_BLUE,
            unselectedItemColor: AppColors.BACKGROUND_DARK,
            onTap: (index) {
              setState(() {
                _selectedIdx = index;
//                currentIndex = index;
              });
            },
            selectedLabelStyle: TextStyle(fontSize: 10, color: AppColors.RED),
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_filled,
                  color: _selectedIdx == 0 ? AppColors.PRIMARY : AppColors.GREY,
                ),
                label: "home".tr,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AssetConstants.PROFILE_ICON,
                  height: 18,
                  color: _selectedIdx == 1 ? AppColors.PRIMARY : AppColors.GREY,
                ),
                label: "profile".tr,
                // ignore: deprecated_member_use
                // title: Text("Main Componets",style: ,),
              ),
            ]),
      ),
    );
  }
}
