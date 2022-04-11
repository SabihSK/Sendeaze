import 'dart:async';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';

import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sendeaze/constants/assets-constants.dart';
import 'package:sendeaze/constants/color-constants.dart';
import 'package:sendeaze/constants/shared-pref-constant.dart';
import 'package:sendeaze/controllers/delivery-controller.dart';
import 'package:sendeaze/controllers/firebase_location_controller.dart';
import 'package:sendeaze/pages/home/drawer-page.dart';
import 'package:sendeaze/pages/home/profile.dart';
import 'package:sendeaze/services/common/shared-preference-service.dart';
import 'package:sendeaze/widgets/app-widgets.dart';

import '../services/orders/orders-services.dart';
import 'delivery/ongoing-delivery-page.dart';
import 'home/home-tab.dart';

class HomePage extends StatefulWidget {
  static String route = "/pages/home-page";

  @override
  _HomePageState createState() => _HomePageState();
}

DeliveriesController _deliveriesController = DeliveriesController();
var deliveryList;
String? driverNameVariable;
double? width;

class _HomePageState extends State<HomePage> {
  int _selectedIdx = 0;
  List<Widget> _widgetOptions = <Widget>[
    HomeTab(),
    EditProfileScreen(
      isOpenFromTab: true,
    ),
  ];
  @override
  void initState() {
    LocationUpdate().updateLocation();
    _deliveriesController.getDeliveriesList();
    getData();
    super.initState();
  }

  late Location location = Location();
  late LocationData locationData;
  getData() async {
    locationData = await location.getLocation();
    driverNameVariable =
        await SharedPref().getDataFromLocal(SharedPrefConstants.NAME);

//   double? lat = 0.0;
//   double? long = 0.0;
//   location.onLocationChanged.listen((LocationData cLoc) async {
//     // cLoc contains the lat and long of the
//     // current user's position in real time,
//     // so we're holding on to it
// //      currentLocation = cLoc;
//     lat = cLoc.latitude;
//     long = cLoc.longitude;
//   });
    String? token = await FirebaseMessaging.instance.getToken();
    print(token);
    String driverId =
        await SharedPref().getDataFromLocal(SharedPrefConstants.driver_id);

    final dbrEf = FirebaseDatabase.instance.ref();

    await dbrEf.child("driverToken/$driverId").update({"driverToken": token});
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
    width = MediaQuery.of(context).size.width;
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
            startDelivery(context, locationData);
          });

          // setState(() {
          //   _deliveriesController.getDeliveriesList();
          //   deliveryList = _deliveriesController.deliveriesList.data;
          //   // setState(() {});
          //   print(deliveryList);
          //   if (deliveryList != null && deliveryList.isNotEmpty) {
          //     if (deliveryList.any((e) =>
          //         e.deliveryStatus != "Delivered" &&
          //         e.deliveryStatus != "Not Delivered" &&
          //         e.deliveryStatus != "Pending")) {
          //       Get.to(
          //         () => OnGoingDeliveryPage(
          //           data: deliveryList.firstWhere(
          //             (e) =>
          //                 e.deliveryStatus != "Delivered" &&
          //                 e.deliveryStatus != "Not Delivered" &&
          //                 e.deliveryStatus != "Pending",
          //           ),
          //         ),
          //       );
          //     } else {
          //       AppWidgets.showSnackBar("No delivery found to deliver!!!");
          //     }
          //   } else {
          //     AppWidgets.showSnackBar("No delivery found to deliver!!!");
          //   }
          // });
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

double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var a = 0.5 -
      cos((lat2 - lat1) * p) / 2 +
      cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}

Future<void> startDelivery(context, locationData) async {
  _deliveriesController.getDeliveriesList();
  deliveryList = _deliveriesController.deliveriesList.data;
  // setState(() {});
  print("=>deliveryList ${deliveryList[0].pickupLatitude}");
  var data = deliveryList.firstWhere(
    (e) =>
        e.deliveryStatus != "Delivered" &&
        e.deliveryStatus != "Not Delivered" &&
        e.deliveryStatus != "Pending",
  );

  PolylinePoints polylinePoints = PolylinePoints();

  String googleAPiKey = "AIzaSyBwviQE9Walln3RAHLawdQDbOpN0q0Jcg8";

  Set<Marker> markers = Set(); //markers for google map
  Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

  LatLng startLocation = LatLng(double.parse(deliveryList[0].pickupLatitude),
      double.parse(deliveryList[0].pickupLongitude));
  LatLng endLocation = LatLng(locationData.latitude, locationData.latitude);

  double distance = 0.0;

  List<LatLng> polylineCoordinates = [];

  PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
    googleAPiKey,
    PointLatLng(startLocation.latitude, startLocation.longitude),
    PointLatLng(endLocation.latitude, endLocation.longitude),
    travelMode: TravelMode.driving,
  );

  if (result.points.isNotEmpty) {
    result.points.forEach((PointLatLng point) {
      polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    });
  } else {
    print(result.errorMessage);
  }

//polulineCoordinates is the List of longitute and latidtude.
  double totalDistance = 0;
  for (var i = 0; i < polylineCoordinates.length - 1; i++) {
    totalDistance += calculateDistance(
        polylineCoordinates[i].latitude,
        polylineCoordinates[i].longitude,
        polylineCoordinates[i + 1].latitude,
        polylineCoordinates[i + 1].longitude);
  }
  print(
      "OnGoingDeliveryPage $totalDistance as ${totalDistance.toStringAsFixed(2)}");

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
          width: width,
        ),
      );
    } else {
      AppWidgets.showSnackBar("No delivery found to deliver!!!");
    }
  } else {
    AppWidgets.showSnackBar("No delivery found to deliver!!!");
  }
}

updateDeliveryList() async {
  await _deliveriesController.getDeliveriesList();
  deliveryList = _deliveriesController.deliveriesList.data;
}
