// To parse this JSON data, do
//
//     final driverLocationModel = driverLocationModelFromJson(jsonString);

import 'dart:convert';

DriverLocationModel driverLocationModelFromJson(String str) =>
    DriverLocationModel.fromJson(json.decode(str));

String driverLocationModelToJson(DriverLocationModel data) =>
    json.encode(data.toJson());

class DriverLocationModel {
  DriverLocationModel({
    this.driver,
  });

  List<Driver>? driver;

  factory DriverLocationModel.fromJson(Map<String, dynamic> json) =>
      DriverLocationModel(
        driver: json["driver"] == null
            ? null
            : List<Driver>.from(json["driver"].map((x) => Driver.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "driver": driver == null
            ? null
            : List<dynamic>.from(driver!.map((x) => x.toJson())),
      };
}

class Driver {
  Driver({
    this.driverId,
    this.latitude,
    this.longitude,
  });

  int? driverId;
  double? latitude;
  double? longitude;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        driverId: json["driver_id"] == null ? null : json["driver_id"],
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "driver_id": driverId == null ? null : driverId,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
      };
}
