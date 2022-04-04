import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sendeaze/constants/assets-constants.dart';
import 'package:sendeaze/constants/color-constants.dart';
import 'package:sendeaze/constants/shared-pref-constant.dart';
import 'package:sendeaze/controllers/change_google_map_polyline_controller.dart';
import 'package:sendeaze/models/driver-location-model.dart';
import 'package:sendeaze/models/orders-list-response.dart';
import 'package:sendeaze/pages/home-page.dart';
import 'package:sendeaze/services/common/shared-preference-service.dart';
import 'package:sendeaze/services/orders/orders-services.dart';
import 'package:sendeaze/widgets/address-card-on-delivery-page.dart';
import 'package:sendeaze/widgets/app-back-button.dart';
import 'package:sendeaze/widgets/app-divder.dart';
import 'package:sendeaze/widgets/app-loader.dart';
import 'package:sendeaze/widgets/button-widget.dart';
import 'package:sendeaze/widgets/order-details-bottom-sheet.dart';
import 'package:sendeaze/widgets/order-info-card-on-delivery-page.dart';
import 'package:url_launcher/url_launcher.dart';

double _originLatitude = 31.771427, _originLongitude = 73.791948;
double _destLatitude = 31.669532, _destLongitude = 74.094264;

const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 40;
const double CAMERA_BEARING = 90;
//LatLng SOURCE_LOCATION = LatLng(_originLatitude, _originLongitude);
LatLng DEST_LOCATION = LatLng(_destLatitude, _destLongitude);

class OnGoingDeliveryPage extends StatefulWidget {
  static String route = "/pages/delivery/ongoing-delivery-page";
  final OrderListData? data;
  final width;
  final distance;

  const OnGoingDeliveryPage(
      {Key? key, this.data, required this.width, this.distance})
      : super(key: key);

  @override
  _OnGoingDeliveryPageState createState() => _OnGoingDeliveryPageState();
}

class _OnGoingDeliveryPageState extends State<OnGoingDeliveryPage>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  Duration _elapsedTime = Duration.zero;

  Completer<GoogleMapController> _controller = Completer();
//  TextEditingController textEditingController = TextEditingController();
  TextEditingController cancelReasonController = TextEditingController();
  FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;

  final DatabaseReference _driversRef =
      FirebaseDatabase.instance.ref().child('drivers');
  List<LatLng> polylineCoordinates = [];
  Set<Marker> _markers = Set<Marker>();
  String? lat;
  String? long;

  Map<PolylineId, Polyline> polylines = {};
  // for my custom marker pins
  late BitmapDescriptor sourceIcon;
  late BitmapDescriptor destinationIcon;
  // a reference to the destination location
  late LocationData destinationLocation;
  // wrapper around the location API
  late Location location;

  late PolylinePoints polylinePoints;

  Set<Polyline> _polylines = Set<Polyline>();
  bool showLoader = false;
  int _radioValue = 0;
  double _rating = 0;

  var _reviews = "";

  String? pinValue;
  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _ticker = this.createTicker((elapsed) {
      setState(() {
        _elapsedTime = elapsed;
      });
    });
    _ticker.start();
    OrderService()
        .updateDeliveryStatus(widget.data!.id!, "On The Way", minutes: 0.0);

    // create an instance of Location
    location = Location();
    polylinePoints = PolylinePoints();
    // set custom marker pins
    setSourceAndDestinationIcons();
    // set the initial location
    setInitialLocation();

    // subscribe to changes in the user's location
    // by "listening" to the location's onLocationChanged event
    location.onLocationChanged.listen((LocationData cLoc) async {
      // cLoc contains the lat and long of the
      // current user's position in real time,
      // so we're holding on to it
//      currentLocation = cLoc;
      lat = cLoc.latitude.toString();
      long = cLoc.longitude.toString();
      updatePinOnMap(cLoc.latitude, cLoc.longitude);
    });
  }

  late LocationData locationData;
  void setSourceAndDestinationIcons() async {
    locationData = await location.getLocation();

    ///
    lat = await SharedPref().getDataFromLocal('lat');
    long = await SharedPref().getDataFromLocal('lng');
    setState(() {});
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: widget.width * 0.25),
        'assets/driving_pin.png');

    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: widget.width * 0.25),
        'assets/destination_map_marker.png');
  }

  void setInitialLocation() async {
    // set the initial location by pulling the user's
    // current location from the location's getLocation()
//    currentLocation = await location.getLocation();
//     currentLocation = LocationData.fromMap({
//       "latitude": SOURCE_LOCATION.latitude,
//       "longitude": SOURCE_LOCATION.longitude
//     });

    // hard-coded destination for this example
    destinationLocation = LocationData.fromMap({
      "latitude": DEST_LOCATION.latitude,
      "longitude": DEST_LOCATION.longitude
    });
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: LatLng(double.parse(lat!), double.parse(long!)),
    );
    if (lat != null && long != null) {
      initialCameraPosition = CameraPosition(
          target: LatLng(double.parse(lat!), double.parse(long!)),
          zoom: CAMERA_ZOOM,
          tilt: CAMERA_TILT,
          bearing: CAMERA_BEARING);
    }
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            GoogleMap(
              mapType: MapType.normal,
              zoomControlsEnabled: false,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              compassEnabled: true,
              tiltGesturesEnabled: true,
              scrollGesturesEnabled: true,
              zoomGesturesEnabled: true,
              markers: _markers,
              initialCameraPosition: initialCameraPosition,
              polylines: _polylines,
//          polylines: Set<Polyline>.of(polylines.values),
              onMapCreated: (GoogleMapController controller) {
                // controller.animateCamera(
                //   CameraUpdate.newCameraPosition(
                //     CameraPosition(
                //       zoom: 7,
                //       target: LatLng((double.parse(lat!)), double.parse(long!)),
                //     ),
                //   ),
                // );
                _controller.complete(controller);
                // my map has completed being created;
                // i'm ready to show the pins on the map
                showPinsOnMap();
              },
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: FloatingActionButton(
                    onPressed: () {
                      _makePhoneCall(widget.data!.customerNumber!);
                    },
                    child: Image.asset(AssetConstants.CALL),
                    mini: true,
                    heroTag: UniqueKey(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: FloatingActionButton(
                    onPressed: () async {
                      await launch(
                          "https://www.google.com/maps/search/${widget.data!.pickupLatitude!},${widget.data!.pickupLongitude!}");
                    },
                    heroTag: UniqueKey(),
                    child: Image.asset(AssetConstants.DIRECTIONS),
                    mini: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: ButtonWidget(
                    btnColor: AppColors.GREEN,
                    btnText: "finish_delivery".tr,
                    onPressed: () {
                      finishDeliveryDialog();
                    },
                  ),
                ),
                cancelBtn(),
              ],
            ),
            Positioned(
              top: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // AppBackButton(
                  //   marginArround: 0,
                  // ),
                  SizedBox(
                    height: 15,
                  ),
                  AddressCard(
                    address: widget.data?.deliveryAddress,
                    customer: widget.data?.customerName,
                    onArrowTap: () => showBottomSheet(context),
                  ),
                  OrderInfoCard(
                    elapsedTime: _elapsedTime,
                    distance: widget.distance,
                    orderId: widget.data!.boxUniqueId!,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  void showPinsOnMap() async {
    lat = await SharedPref().getDataFromLocal('lat');
    long = await SharedPref().getDataFromLocal('lng');

    // get a LatLng for the source location
    // from the LocationData currentLocation object
    var pinPosition = LatLng(double.parse(lat!), double.parse(long!));
    // var pinPosition =
    //     LatLng(currentLocation!.latitude!, currentLocation!.longitude!);
    // get a LatLng out of the LocationData object
    var destPosition = LatLng(double.parse(widget.data!.deliveryLongitude!),
        double.parse(widget.data!.deliveryLatitude!));
    // var destPosition =
    //     LatLng(destinationLocation.latitude!, destinationLocation.longitude!);
    // add the initial source location pin
    _markers.add(Marker(
        markerId: MarkerId('sourcePin'),
        position: pinPosition,
        icon: sourceIcon));
    // destination pin
    _markers.add(Marker(
        markerId: MarkerId('destPin'),
        position: destPosition,
        icon: destinationIcon));
    // set the route lines on the map from source to destination
    // for more info follow this tutorial
    setPolylines();
  }

  void setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        Google_Map_key,
        PointLatLng(double.parse(lat!), double.parse(long!)),
        PointLatLng(double.parse(widget.data!.deliveryLongitude!),
            double.parse(widget.data!.deliveryLatitude!)));
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//         Google_Map_key,
// //        PointLatLng(currentLocation!.latitude!, currentLocation!.longitude!),
//         PointLatLng(_originLatitude, _originLongitude),
//         PointLatLng(_destLatitude, _destLongitude),
//         travelMode: TravelMode.driving);
//     // PointLatLng(
//     //         destinationLocation.latitude!, destinationLocation.longitude!));
    print(
        "----poly lines ${result.status}  ${result.points.length} ${result.errorMessage}");
    if (result.points.isNotEmpty) {
      polylineCoordinates = await PolylineController().decode(lat, long,
          widget.data?.deliveryLatitude, widget.data?.deliveryLongitude);

      // result.points.forEach((PointLatLng point) {
      //   polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      // });
      setState(() {
        _polylines.add(Polyline(
            width: 5, // set the width of the polylines
            polylineId: PolylineId("poly"),
            color: Color.fromARGB(255, 40, 122, 198),
            points: polylineCoordinates));
      });
    }
  }

  void updatePinOnMap(lat, long) async {
    // create a new CameraPosition instance
    // every time the location changes, so the camera
    // follows the pin as it moves with an animation
    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      target: LatLng(lat, long),
      bearing: CAMERA_BEARING,
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    // do this inside the setState() so Flutter gets notified
    // that a widget update is due
    if (this.mounted) {
      setState(() {
        // updated position
        var pinPosition = LatLng(lat, long);
        // the trick is to remove the marker (by id)
        // and add it again at the updated location
        _markers.removeWhere((m) => m.markerId.value == "sourcePin");
        _markers.add(Marker(
            markerId: MarkerId("sourcePin"),
            position: pinPosition, // updated position
            icon: sourceIcon));
        // Get.snackbar(
        //   "Updated Coordinates",
        //   "newLat: $lat newlong: $long",
        // );
        // updateDatabaseWithUpdatedCoordinates(lat, long);
      });
    }
  }

  cancelBtn() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 12),
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          cancelReasonDialog();
        },
        child: Text(
          "Cancel Delivery",
          style: TextStyle(color: AppColors.RED, fontWeight: FontWeight.bold),
        ),
        style: OutlinedButton.styleFrom(
          shape: StadiumBorder(),
          backgroundColor: AppColors.WHITE,
          side: BorderSide(width: 2.0, color: AppColors.RED),
        ),
      ),
    );
  }

  List<String> _listOfReasons = [
    "Customer is not available",
    "Destination is wrong",
    "Customer cancelled order",
    "Customer does not have the secret code"
  ];
  bool? val = false;

  Future<dynamic> cancelReasonDialog() {
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, state) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            backgroundColor: Color(0xffF2F2F2),
            title: null,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Please specify a reason",
                  style: Get.textTheme.subtitle2!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                Container(
                  height: 170,
                  width: 300,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return AppCheckListTile(
                        title: _listOfReasons[index],
                        groupValue: _radioValue,
                        onChanged: (v) {
                          _handleRadioValueChange(v);
                          state(() {});
                        },
                        value: index,
                      );
                    },
                    itemCount: _listOfReasons.length,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Others:  ",
                      style: Get.textTheme.caption!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * .5,
                      // height: 30,
                      child: TextField(
                        controller: cancelReasonController,
                        decoration: InputDecoration(
                          hintText: "Please specify reason",
                          hintStyle: Get.textTheme.caption!.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                showLoader
                    ? CircularProgressIndicator()
                    : ButtonWidget(
                        onPressed: () {
                          state(() {
                            showLoader = true;
                          });
                          OrderService()
                              .updateDeliveryStatus(
                            widget.data!.id!,
                            "Not Delivered",
                            reason: cancelReasonController.text.isNotEmpty
                                ? cancelReasonController.text
                                : _listOfReasons[_radioValue],
                          )
                              .then((value) {
                            state(() {
                              showLoader = false;
                            });
//                        Get.offAndToNamed(HomePage.route);
                            if (value["error"] == null) {
                              Get.offAllNamed(HomePage.route,
                                  arguments: "Arguments");
                            }
                          });
                        },
                        btnText: "submit".tr,
                      )
              ],
            ),
          );
        });
      },
    );
  }

  Future<dynamic> finishDeliveryDialog() {
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, state) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            backgroundColor: AppColors.WHITE,
            title: null,
            content: Container(
              color: AppColors.WHITE,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElapsedTimeText(elapsed: _elapsedTime),
                      VerticalDivider(),
                      _infoCard(title: "Travel Dis.", value: "5m"),
                      VerticalDivider(),
                      _infoCard(title: "Order #", value: "53415"),
                    ],
                  ),
                  SizedBox(height: 8),
                  AppDivider(),
                  SizedBox(height: 8),
                  Text(
                    "Enter code to finish delivery",
                    style: Get.textTheme.subtitle2!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 15),
                  PinCodeTextField(
                    appContext: Get.context!,
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    textStyle: TextStyle(color: AppColors.WHITE),
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                      inactiveFillColor: AppColors.BACKGROUND_LIGHT,
                      inactiveColor: AppColors.BACKGROUND_LIGHT,
                      shape: PinCodeFieldShape.box,
                      // selectedColor: AppColors.WHITE,
                      // selectedFillColor: AppColors.WHITE,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 35,
                      activeColor: AppColors.PRIMARY,
                      fieldWidth: 30,
                      activeFillColor: AppColors.PRIMARY,
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: AppColors.WHITE,
                    enableActiveFill: true,
                    //controller: textEditingController,
                    onCompleted: (v) {
                      print("Completed $v");
                      setState(() {
                        pinValue = v;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        pinValue = value;
                      });
                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      return true;
                    },
                  ),
                  showLoader
                      ? CircularProgressIndicator()
                      : ButtonWidget(
                          btnColor: AppColors.GREEN,
                          onPressed: () {
                            state(() {
                              showLoader = true;
                            });
                            OrderService()
                                .updateDeliveryStatus(
                                    widget.data!.id!, "Delivered",
                                    minutes: _elapsedTime.inMinutes,
                                    secretCode: pinValue)
                                .then((value) {
                              setState(() {
                                showLoader = false;
                              });
                              if (value["error"] == null) {
                                // Get.back();
                                // Navigator.pop(context);
                                // Navigator.of(context, rootNavigator: true)
                                //     .pop('dialog');
                                Navigator.pop(context);

                                // Navigator.of(context).pop();
                                ratingBarDialog();
                              }
                            });
                          },
                          btnText: "submit".tr,
                        ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  Future<dynamic> ratingBarDialog() {
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, state) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            backgroundColor: AppColors.WHITE,
            title: null,
            content: Container(
              color: AppColors.WHITE,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Please rate your delivery",
                    style: Get.textTheme.subtitle2!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 15),
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    unratedColor: AppColors.BACKGROUND_LIGHT,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      _rating = rating;
                      print(rating);
                    },
                  ),
                  SizedBox(height: 15),
                  ButtonWidget(
                    btnColor: AppColors.GREEN,
                    onPressed: () {
                      OrderService()
                          .ratingAndReviews(
                              rating: _rating,
                              customerID: widget.data!.customerId,
                              reviews: _reviews)
                          .then((value) {
                        state(() {
                          showLoader = false;
                        });
                        if (value["error"] == null ||
                            value["error"] ==
                                "You can not give your feedback again.") {
                          Get.offAllNamed(HomePage.route,
                              arguments: "rating Done");
                          startDelivery(context, locationData);
                        }
                      });
                    },
                    btnText: "submit".tr,
                  )
                ],
              ),
            ),
          );
        });
      },
    );
  }

  Column _infoCard({String title = "Travel Time", String value = "00:20:12"}) {
    return Column(
      children: [
        Text(
          title,
          style: Get.textTheme.caption!.copyWith(fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: Get.textTheme.button,
        ),
      ],
    );
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
      }
    });
  }

  Future<dynamic> showBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return DetailsBottomSheet(
            data: widget.data,
          );
        },
        backgroundColor: Colors.transparent,
        clipBehavior: Clip.antiAlias);
  }

//   void updateDatabaseWithUpdatedCoordinates(
//       double? latitude, double? longitude) async {
//     String driverId =
//         await SharedPref().getDataFromLocal(SharedPrefConstants.driver_id);

//     // Driver(
//     //     latitude: latitude,
//     //     longitude: longitude,
//     //     driverId: int.parse(driverId));

//     await _driversRef.set({
//       "latitude": latitude,
//       "longitude": longitude,
//       "driverId": 29
// //      driverId: int.parse(driverId)
//     }).then((value) {
//       print("---- data saved");
//     }).catchError((onError) {
//       print("---- onError $onError");
//     });
//   }
}

class AppCheckListTile extends StatelessWidget {
  final String? title;
  final dynamic value;
  final ValueChanged? onChanged;
  final groupValue;
  const AppCheckListTile(
      {Key? key, this.title, this.value, this.onChanged, this.groupValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            height: 40,
            child: Radio(
              value: value ?? false,
              onChanged: onChanged,
              groupValue: groupValue,
            )),
        Expanded(
          child: Text(
            title ?? "Customer is not available",
            style: Get.textTheme.caption!.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }
}
