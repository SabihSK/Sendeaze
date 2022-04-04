import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sendeaze/constants/shared-pref-constant.dart';
import 'package:sendeaze/controllers/change_google_map_polyline_controller.dart';
import 'package:sendeaze/models/orders-list-response.dart';
import 'package:sendeaze/pages/delivery/ongoing-delivery-page.dart';
import 'package:sendeaze/services/common/shared-preference-service.dart';
import 'package:sendeaze/widgets/app-back-button.dart';
import 'package:sendeaze/widgets/order-details-bottom-sheet.dart';

class DeliveryDetailsPage extends StatefulWidget {
  static String route = "/pages/delivery/delivery-detail-page";
  final OrderListData? data;
  final width;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  const DeliveryDetailsPage({Key? key, this.data, required this.width})
      : super(key: key);

  @override
  _DeliveryDetailsPageState createState() => _DeliveryDetailsPageState();
}

class _DeliveryDetailsPageState extends State<DeliveryDetailsPage> {
// 24.950973, 67.080255

  Completer<GoogleMapController> _controller = Completer();
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  TextEditingController textEditingController = TextEditingController();
  List<LatLng> polylineCoordinates = [];
  // for my custom marker pins
  late BitmapDescriptor sourceIcon;
  late BitmapDescriptor destinationIcon;
  Set<Marker> _markers = Set<Marker>();
  String? lat;
  String? long;
  late LocationData destinationLocation;
  late PolylinePoints polylinePoints;

  Set<Polyline> _polylines = Set<Polyline>();

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    polylinePoints = PolylinePoints();
    // set custom marker pins
    Future.delayed(Duration.zero, () {
      setSourceAndDestinationIcons();
    });
  }

  void setSourceAndDestinationIcons() async {
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
    if (result.points.isNotEmpty) {
      polylineCoordinates = await PolylineController().decode(lat, long,
          widget.data?.deliveryLatitude, widget.data?.deliveryLongitude);

      // result.points.forEach((PointLatLng point) async {
      //   polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      //   // polylineCoordinates = await PolylineController().decode();
      // });
      setState(() {
        _polylines.add(Polyline(
            width: 5, // set the width of the polylines
            polylineId: PolylineId("poly"),
            color: Color.fromARGB(255, 40, 122, 198),
            points: polylineCoordinates)); //PolylineController().decode()
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
    });
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
      zoom: 6,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: LatLng(double.parse(lat!), double.parse(long!)),
    );
    if (lat != null && long != null) {
      initialCameraPosition = CameraPosition(
          target: LatLng(double.parse(lat!), double.parse(long!)),
          zoom: 7,
          tilt: CAMERA_TILT,
          bearing: CAMERA_BEARING);
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                Container(
                  height: Get.height * .65,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: true,
                    mapToolbarEnabled: true,
                    myLocationEnabled: true,
                    compassEnabled: true,
                    tiltGesturesEnabled: true,
                    scrollGesturesEnabled: true,
                    zoomGesturesEnabled: true,
                    markers: _markers,
                    initialCameraPosition: initialCameraPosition,
                    polylines: _polylines,
                    rotateGesturesEnabled: true,
                    onMapCreated: (controller) async {
                      _controller.complete(controller);
                      showPinsOnMap();
                      await updateCameraLocation(
                        LatLng(double.parse(lat!), double.parse(long!)),
                        LatLng(double.parse(widget.data!.deliveryLongitude!),
                            double.parse(widget.data!.deliveryLatitude!)),
                        controller,
                      );
                    },
                  ),
                ),
                Spacer()
              ],
            ),
            AppBackButton(),
            DetailsBottomSheet(data: widget.data),
          ],
        ),
      ),
    );
  }
}

//?--- updateCameraLocation ---

Future<void> updateCameraLocation(
  LatLng source,
  LatLng destination,
  GoogleMapController mapController,
) async {
  // ignore: unnecessary_null_comparison
  if (mapController == null) return;

  LatLngBounds bounds;

  if (source.latitude > destination.latitude &&
      source.longitude > destination.longitude) {
    bounds = LatLngBounds(southwest: destination, northeast: source);
  } else if (source.longitude > destination.longitude) {
    bounds = LatLngBounds(
        southwest: LatLng(source.latitude, destination.longitude),
        northeast: LatLng(destination.latitude, source.longitude));
  } else if (source.latitude > destination.latitude) {
    bounds = LatLngBounds(
        southwest: LatLng(destination.latitude, source.longitude),
        northeast: LatLng(source.latitude, destination.longitude));
  } else {
    bounds = LatLngBounds(southwest: source, northeast: destination);
  }

  CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 50);

  return checkCameraLocation(cameraUpdate, mapController);
}

Future<void> checkCameraLocation(
    CameraUpdate cameraUpdate, GoogleMapController mapController) async {
  mapController.animateCamera(cameraUpdate);
  LatLngBounds l1 = await mapController.getVisibleRegion();
  LatLngBounds l2 = await mapController.getVisibleRegion();

  if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90) {
    return checkCameraLocation(cameraUpdate, mapController);
  }
}
