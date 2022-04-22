import 'package:sendeaze/constants/api-constants.dart';
import 'package:sendeaze/constants/shared-pref-constant.dart';
import 'package:sendeaze/models/orders-list-response.dart';
import 'package:sendeaze/services/common/api-services.dart';
import 'package:sendeaze/services/common/shared-preference-service.dart';
import 'package:sendeaze/widgets/app-widgets.dart';
import 'package:geolocator/geolocator.dart';

class OrderService {
  Future<OrderListResponse> getDeliveredBasedOnStatus(status) async {
    String token =
        await SharedPref().getDataFromLocal(SharedPrefConstants.token);
    String driverId =
        await SharedPref().getDataFromLocal(SharedPrefConstants.driver_id);
    final body = {
      "validation_token": token,
      "driver_id": int.parse(driverId),
      "status": status
    };
    final httpJson =
        await ApiService().doPost(AppApi.DELIVERY_LIST_BASED_ON_STATUS, body);
    OrderListResponse response = OrderListResponse.fromJson(httpJson);
    if (response.error != null) {
      AppWidgets.showSnackBar(response.error.toString());
    }
    if (response.code != null && response.code == "200") {
      return response;
    }
    return response;
  }

  var deliveriesData;

  Future<OrderListResponse> getDeliveries() async {
    try {} catch (e) {
      print(e);
    }
    // //  Position? position = await getCurrentLocation();
    //   Position? position = await Geolocator.getCurrentPosition(
    //       desiredAccuracy: LocationAccuracy.high);
    String lat = await SharedPref().getDataFromLocal('lat');
    print("=>lat $lat");
    String long = await SharedPref().getDataFromLocal('lng');
    print("=>lan $long");
    String token =
        await SharedPref().getDataFromLocal(SharedPrefConstants.token);
    String driverId =
        await SharedPref().getDataFromLocal(SharedPrefConstants.driver_id);
    final body = {
      "validation_token": token,
      "driver_id": int.parse(driverId),
      // "current_latitude": 30.1872069,
      // "current_longitude": 71.4339977
      "current_latitude": lat,
      "current_longitude": long
    };
    final httpJson =
        await ApiService().doPost(AppApi.TODAY_DELIVERIES_LIST, body);
    OrderListResponse response = OrderListResponse.fromJson(httpJson);
    if (response.error != null) {
      print(response.error.toString());
    }
    if (response.code != null && response.code == "200") {
      deliveriesData = response;
      return response;
    }
    deliveriesData = response;
    return response;
  }

  Future<dynamic> markAsPicked(dynamic idsStatuses) async {
    String token =
        await SharedPref().getDataFromLocal(SharedPrefConstants.token);
    String driverId =
        await SharedPref().getDataFromLocal(SharedPrefConstants.driver_id);
    final body = {
      "validation_token": token,
      "driver_id": int.parse(driverId),
      "ids_statuses": idsStatuses
    };
    final httpJson = await ApiService().doPost(AppApi.MARK_AS_PICKED, body);
    if (httpJson["error"] != null) {
      AppWidgets.showSnackBar(httpJson["error"]);
    }
    if (httpJson["code"] != null && httpJson["code"] == "200") {
      AppWidgets.showSnackBar(httpJson["message"]);

      return httpJson;
    }
    return httpJson;
  }

  Future<dynamic> updateDeliveryStatus(int? deliveryId, String status,
      {String? reason, secretCode, num? minutes, distance}) async {
    String token =
        await SharedPref().getDataFromLocal(SharedPrefConstants.token);
    String driverId =
        await SharedPref().getDataFromLocal(SharedPrefConstants.driver_id);
    final body = {
      "validation_token": token,
      "driver_id": int.parse(driverId),
      "delivery_id": deliveryId,
      "status": status,
      "secret_code": secretCode,
      "not_delivered_reason": reason,
      "total_delivery_time": minutes,
      "total_distance_travelled_km": distance
    };
    final httpJson =
        await ApiService().doPost(AppApi.UPDATE_DELIVERY_STATUS, body);
    if (httpJson["error"] != null) {
      AppWidgets.showSnackBar(httpJson["error"]);
    }
    if (httpJson["code"] != null && httpJson["code"] == "200") {
      AppWidgets.showSnackBar(httpJson["message"]);

      return httpJson;
    }
    return httpJson;
  }

  Future<dynamic> ratingAndReviews({customerID, rating, reviews}) async {
    String driverId =
        await SharedPref().getDataFromLocal(SharedPrefConstants.driver_id);
    final body = {
      "rating_type": "D2C",
      "driver_id": int.parse(driverId),
      "customer_id": customerID,
      "rating": rating,
      "review": reviews,
    };
    final httpJson =
        await ApiService().doPost(AppApi.GIVE_RATING_REVIEWS, body);
    if (httpJson["error"] != null) {
      AppWidgets.showSnackBar(httpJson["error"]);
    }
    if (httpJson["code"] != null && httpJson["code"] == "200") {
      AppWidgets.showSnackBar(httpJson["message"]);

      return httpJson;
    }
    return httpJson;
  }
}

Position? currenLocation;
Future<Position?> getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permantly denied, we cannot request permissions.');
  }
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      return Future.error(
          'Location permissions are denied (actual value: $permission).');
    }
  }
  currenLocation = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  SharedPref().setStringToLocal('lat', currenLocation!.latitude.toString());
  SharedPref().setStringToLocal('lng', currenLocation!.longitude.toString());
  return currenLocation;
}
