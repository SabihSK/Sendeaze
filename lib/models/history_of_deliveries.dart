class HistoryOfDeliveries {
  String? code;
  String? message;
  String? error;
  Datum? datum;

  HistoryOfDeliveries({this.code, this.message, this.error, this.datum});

  HistoryOfDeliveries.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    error = json['error'];
    datum = json['data'] != null ? new Datum.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.datum != null) {
      data['data'] = this.datum!.toJson();
    }
    return data;
  }
}

class Datum {
  Driver? driver;
  List<Data>? data;

  Datum({this.driver, this.data});

  Datum.fromJson(Map<String, dynamic> json) {
    driver =
        json['driver'] != null ? new Driver.fromJson(json['driver']) : null;
    if (json['deliveries'] != null) {
      data = <Data>[];
      json['deliveries'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.driver != null) {
      data['driver'] = this.driver!.toJson();
    }
    if (this.data != null) {
      data['deliveries'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Driver {
  int? id;
  String? name;
  String? email;
  String? validationToken;
  String? firebaseToken;
  Null? emailVerifiedAt;
  int? verified;
  String? iqNum;
  String? dob;
  String? medicalNum;
  String? licenseNum;
  String? lExpireNum;
  String? mobileNum;
  Null? address;
  String? profileImg;
  int? status;
  String? token;
  String? createdAt;
  String? updatedAt;
  Null? createdBy;
  Null? updatedBy;
  int? isDriverOnline;
  int? isDriverBusy;
  Null? currentLat;
  Null? currentLang;

  Driver(
      {this.id,
      this.name,
      this.email,
      this.validationToken,
      this.firebaseToken,
      this.emailVerifiedAt,
      this.verified,
      this.iqNum,
      this.dob,
      this.medicalNum,
      this.licenseNum,
      this.lExpireNum,
      this.mobileNum,
      this.address,
      this.profileImg,
      this.status,
      this.token,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      this.isDriverOnline,
      this.isDriverBusy,
      this.currentLat,
      this.currentLang});

  Driver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    validationToken = json['validation_token'];
    firebaseToken = json['firebase_token'];
    emailVerifiedAt = json['email_verified_at'];
    verified = json['verified'];
    iqNum = json['iq_num'];
    dob = json['dob'];
    medicalNum = json['medical_num'];
    licenseNum = json['license_num'];
    lExpireNum = json['l_expire_num'];
    mobileNum = json['mobile_num'];
    address = json['address'];
    profileImg = json['profile_img'];
    status = json['status'];
    token = json['token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    isDriverOnline = json['is_driver_online'];
    isDriverBusy = json['is_driver_busy'];
    currentLat = json['current_lat'];
    currentLang = json['current_lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['validation_token'] = this.validationToken;
    data['firebase_token'] = this.firebaseToken;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['verified'] = this.verified;
    data['iq_num'] = this.iqNum;
    data['dob'] = this.dob;
    data['medical_num'] = this.medicalNum;
    data['license_num'] = this.licenseNum;
    data['l_expire_num'] = this.lExpireNum;
    data['mobile_num'] = this.mobileNum;
    data['address'] = this.address;
    data['profile_img'] = this.profileImg;
    data['status'] = this.status;
    data['token'] = this.token;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['is_driver_online'] = this.isDriverOnline;
    data['is_driver_busy'] = this.isDriverBusy;
    data['current_lat'] = this.currentLat;
    data['current_lang'] = this.currentLang;
    return data;
  }
}

// class Data {
//   int? id;
//   String? boxUniqueId;
//   int? customerId;
//   String? customerName;
//   String? customerEmail;
//   String? customerNumber;
//   String? pickupLocation;
//   String? pickupLatitude;
//   String? pickupLongitude;
//   String? deliveryAddress;
//   String? deliveryLatitude;
//   String? deliveryLongitude;
//   String? deliveryDetails;
//   String? areaName;
//   String? areaId;
//   String? boxSize;
//   String? status;
//   String? secretCode;
//   int? driverId;
//   int? vehicleId;
//   String? deliveredAt;
//   String? deliveryStatus;
//   double? estimatedDistance;
//   int? totalDeliveryTime;
//   double? totalDistanceTravelledKm;
//   String? notDeliveredReason;
//   String? pickedAt;
//   int? pickedBy;
//   String? createdAt;
//   int? createdBy;
//   String? updatedAt;
//   int? displayOrder;

//   Data(
//       {this.id,
//       this.boxUniqueId,
//       this.customerId,
//       this.customerName,
//       this.customerEmail,
//       this.customerNumber,
//       this.pickupLocation,
//       this.pickupLatitude,
//       this.pickupLongitude,
//       this.deliveryAddress,
//       this.deliveryLatitude,
//       this.deliveryLongitude,
//       this.deliveryDetails,
//       this.areaName,
//       this.areaId,
//       this.boxSize,
//       this.status,
//       this.secretCode,
//       this.driverId,
//       this.vehicleId,
//       this.deliveredAt,
//       this.deliveryStatus,
//       this.estimatedDistance,
//       this.totalDeliveryTime,
//       this.totalDistanceTravelledKm,
//       this.notDeliveredReason,
//       this.pickedAt,
//       this.pickedBy,
//       this.createdAt,
//       this.createdBy,
//       this.updatedAt,
//       this.displayOrder});

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     boxUniqueId = json['box_unique_id'];
//     customerId = json['customer_id'];
//     customerName = json['customer_name'];
//     customerEmail = json['customer_email'];
//     customerNumber = json['customer_number'];
//     pickupLocation = json['pickup_location'];
//     pickupLatitude = json['pickup_latitude'];
//     pickupLongitude = json['pickup_longitude'];
//     deliveryAddress = json['delivery_Address'];
//     deliveryLatitude = json['delivery_latitude'];
//     deliveryLongitude = json['delivery_longitude'];
//     deliveryDetails = json['delivery_details'];
//     areaName = json['area_name'];
//     areaId = json['area_id'];
//     boxSize = json['box_size'];
//     status = json['status'];
//     secretCode = json['secret_code'];
//     driverId = json['driver_id'];
//     vehicleId = json['vehicle_id'];
//     deliveredAt = json['delivered_at'];
//     deliveryStatus = json['delivery_status'];
//     estimatedDistance = json['estimated_distance'];
//     totalDeliveryTime = json['total_delivery_time'];
//     totalDistanceTravelledKm = json['total_distance_travelled_km'];
//     notDeliveredReason = json['not_delivered_reason'];
//     pickedAt = json['picked_at'];
//     pickedBy = json['picked_by'];
//     createdAt = json['created_at'];
//     createdBy = json['created_by'];
//     updatedAt = json['updated_at'];
//     displayOrder = json['display_order'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['box_unique_id'] = this.boxUniqueId;
//     data['customer_id'] = this.customerId;
//     data['customer_name'] = this.customerName;
//     data['customer_email'] = this.customerEmail;
//     data['customer_number'] = this.customerNumber;
//     data['pickup_location'] = this.pickupLocation;
//     data['pickup_latitude'] = this.pickupLatitude;
//     data['pickup_longitude'] = this.pickupLongitude;
//     data['delivery_Address'] = this.deliveryAddress;
//     data['delivery_latitude'] = this.deliveryLatitude;
//     data['delivery_longitude'] = this.deliveryLongitude;
//     data['delivery_details'] = this.deliveryDetails;
//     data['area_name'] = this.areaName;
//     data['area_id'] = this.areaId;
//     data['box_size'] = this.boxSize;
//     data['status'] = this.status;
//     data['secret_code'] = this.secretCode;
//     data['driver_id'] = this.driverId;
//     data['vehicle_id'] = this.vehicleId;
//     data['delivered_at'] = this.deliveredAt;
//     data['delivery_status'] = this.deliveryStatus;
//     data['estimated_distance'] = this.estimatedDistance;
//     data['total_delivery_time'] = this.totalDeliveryTime;
//     data['total_distance_travelled_km'] = this.totalDistanceTravelledKm;
//     data['not_delivered_reason'] = this.notDeliveredReason;
//     data['picked_at'] = this.pickedAt;
//     data['picked_by'] = this.pickedBy;
//     data['created_at'] = this.createdAt;
//     data['created_by'] = this.createdBy;
//     data['updated_at'] = this.updatedAt;
//     data['display_order'] = this.displayOrder;
//     return data;
//   }
// }

class Data {
  int? id;
  String? boxUniqueId;
  int? customerId;
  String? customerName;
  String? customerEmail;
  String? customerNumber;
  String? pickupLocation;
  String? pickupLatitude;
  String? pickupLongitude;
  String? deliveryAddress;
  String? deliveryLatitude;
  String? deliveryLongitude;
  String? deliveryDetails;
  String? areaName;
  String? areaId;
  String? boxSize;
  String? status;
  String? secretCode;
  int? driverId;
  int? vehicleId;
  String? deliveredAt;
  String? deliveryStatus;
  double? estimatedDistance;
  int? totalDeliveryTime;
  double? totalDistanceTravelledKm;
  String? notDeliveredReason;
  String? pickedAt;
  int? pickedBy;
  String? createdAt;
  int? createdBy;
  String? updatedAt;

  Data(
      {this.id,
      this.boxUniqueId,
      this.customerId,
      this.customerName,
      this.customerEmail,
      this.customerNumber,
      this.pickupLocation,
      this.pickupLatitude,
      this.pickupLongitude,
      this.deliveryAddress,
      this.deliveryLatitude,
      this.deliveryLongitude,
      this.deliveryDetails,
      this.areaName,
      this.areaId,
      this.boxSize,
      this.status,
      this.secretCode,
      this.driverId,
      this.vehicleId,
      this.deliveredAt,
      this.deliveryStatus,
      this.estimatedDistance,
      this.totalDeliveryTime,
      this.totalDistanceTravelledKm,
      this.notDeliveredReason,
      this.pickedAt,
      this.pickedBy,
      this.createdAt,
      this.createdBy,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    boxUniqueId = json['box_unique_id'];
    customerId = json['customer_id'];
    customerName = json['customer_name'];
    customerEmail = json['customer_email'];
    customerNumber = json['customer_number'];
    pickupLocation = json['pickup_location'];
    pickupLatitude = json['pickup_latitude'];
    pickupLongitude = json['pickup_longitude'];
    deliveryAddress = json['delivery_Address'];
    deliveryLatitude = json['delivery_latitude'];
    deliveryLongitude = json['delivery_longitude'];
    deliveryDetails = json['delivery_details'];
    areaName = json['area_name'];
    areaId = json['area_id'];
    boxSize = json['box_size'];
    status = json['status'];
    secretCode = json['secret_code'];
    driverId = json['driver_id'];
    vehicleId = json['vehicle_id'];
    deliveredAt = json['delivered_at'];
    deliveryStatus = json['delivery_status'];
    estimatedDistance =
        json['estimated_distance'] == 0 ? 0.0 : json['estimated_distance'];
    totalDeliveryTime = json['total_delivery_time'];
    totalDistanceTravelledKm = json['total_distance_travelled_km'] + 0.0;
    notDeliveredReason = json['not_delivered_reason'];
    pickedAt = json['picked_at'];
    pickedBy = json['picked_by'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['box_unique_id'] = this.boxUniqueId;
    data['customer_id'] = this.customerId;
    data['customer_name'] = this.customerName;
    data['customer_email'] = this.customerEmail;
    data['customer_number'] = this.customerNumber;
    data['pickup_location'] = this.pickupLocation;
    data['pickup_latitude'] = this.pickupLatitude;
    data['pickup_longitude'] = this.pickupLongitude;
    data['delivery_Address'] = this.deliveryAddress;
    data['delivery_latitude'] = this.deliveryLatitude;
    data['delivery_longitude'] = this.deliveryLongitude;
    data['delivery_details'] = this.deliveryDetails;
    data['area_name'] = this.areaName;
    data['area_id'] = this.areaId;
    data['box_size'] = this.boxSize;
    data['status'] = this.status;
    data['secret_code'] = this.secretCode;
    data['driver_id'] = this.driverId;
    data['vehicle_id'] = this.vehicleId;
    data['delivered_at'] = this.deliveredAt;
    data['delivery_status'] = this.deliveryStatus;
    data['estimated_distance'] = this.estimatedDistance;
    data['total_delivery_time'] = this.totalDeliveryTime;
    data['total_distance_travelled_km'] = this.totalDistanceTravelledKm;
    data['not_delivered_reason'] = this.notDeliveredReason;
    data['picked_at'] = this.pickedAt;
    data['picked_by'] = this.pickedBy;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
