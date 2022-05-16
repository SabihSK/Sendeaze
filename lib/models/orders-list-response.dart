//
// class OrderListResponse {
//   OrderListResponse({
//     this.code,
//     this.message,
//     this.error,
//     this.data,
//   });
//
//   String?? code;
//   String?? message;
//   dynamic error;
//   List<OrderListData>? data;
//
//   factory OrderListResponse.fromJson(Map<String??, dynamic> json) => OrderListResponse(
//     code: json["code"] == null ? null : json["code"],
//     message: json["message"] == null ? null : json["message"],
//     error: json["error"],
//     data: json["data"] == null ? null : List<OrderListData>.from(json["data"].map((x) => OrderListData.fromJson(x))),
//   );
//
// }
//
// class OrderListData {
//   OrderListData({
//     this.id,
//     this.customerName,
//     this.customerEmail,
//     this.customerNumber,
//     this.pickupLocation,
//     this.pickupLatitude,
//     this.pickupLongitude,
//     this.deliveryAddress,
//     this.deliveryLatitude,
//     this.deliveryLongitude,
//     this.deliveryDetails,
//     this.areaName,
//     this.areaId,
//     this.boxSize,
//     this.status,
//     this.deliveryStatus,
//     this.pickedAt,
//     this.pickedBy,
//     this.createdAt,
//     this.createdBy,
//     this.updatedAt,
//   });
//
//   int?? id;
//   String?? customerName;
//   String?? customerEmail;
//   String?? customerNumber;
//   String?? pickupLocation;
//   String?? pickupLatitude;
//   String?? pickupLongitude;
//   String?? deliveryAddress;
//   String?? deliveryLatitude;
//   String?? deliveryLongitude;
//   String?? deliveryDetails;
//   String?? areaName;
//   String?? areaId;
//   String?? boxSize;
//   String?? status;
//   String?? deliveryStatus;
//   DateTime? pickedAt;
//   DateTime? pickedBy;
//   DateTime? createdAt;
//   DateTime? createdBy;
//   DateTime? updatedAt;
//
//   factory OrderListData.fromJson(Map<String??, dynamic> json) => OrderListData(
//     id: json["id"] == null ? null : json["id"],
//     customerName: json["customer_name"] == null ? null : json["customer_name"],
//     customerEmail: json["customer_email"] == null ? null : json["customer_email"],
//     customerNumber: json["customer_number"] == null ? null : json["customer_number"],
//     pickupLocation: json["pickup_location"] == null ? null : json["pickup_location"],
//     pickupLatitude: json["pickup_latitude"] == null ? null : json["pickup_latitude"],
//     pickupLongitude: json["pickup_longitude"] == null ? null : json["pickup_longitude"],
//     deliveryAddress: json["delivery_Address"] == null ? null : json["delivery_Address"],
//     deliveryLatitude: json["delivery_latitude"] == null ? null : json["delivery_latitude"],
//     deliveryLongitude: json["delivery_longitude"] == null ? null : json["delivery_longitude"],
//     deliveryDetails: json["delivery_details"] == null ? null : json["delivery_details"],
//     areaName: json["area_name"] == null ? null : json["area_name"],
//     areaId: json["area_id"] == null ? null : json["area_id"],
//     boxSize: json["box_size"] == null ? null : json["box_size"],
//     status: json["status"] == null ? null : json["status"],
//     deliveryStatus: json["delivery_status"] == null ? null : json["delivery_status"],
//     pickedAt: json["picked_at"],
//     pickedBy: json["picked_by"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     createdBy: json["created_by"],
//     updatedAt: json["updated_at"],
//   );
//
// }

// class OrderListResponse {
//   OrderListResponse({
//     this.code,
//     this.message,
//     this.error,
//     this.data,
//   });

//   String? code;
//   String? message;
//   dynamic error;
//   List<OrderListData>? data;

//   factory OrderListResponse.fromJson(Map<String?, dynamic> json) =>
//       OrderListResponse(
//         code: json["code"] == null ? null : json["code"],
//         message: json["message"] == null ? null : json["message"],
//         error: json["error"],
//         data: json["data"] == null
//             ? null
//             : List<OrderListData>.from(
//                 json["data"].map((x) => OrderListData.fromJson(x))),
//       );
// }

// class OrderListData {
//   OrderListData({
//     this.id,
//     this.boxUniqueId,
//     this.customerId,
//     this.customerName,
//     this.customerEmail,
//     this.customerNumber,
//     this.pickupLocation,
//     this.pickupLatitude,
//     this.pickupLongitude,
//     this.deliveryAddress,
//     this.deliveryLatitude,
//     this.deliveryLongitude,
//     this.deliveryDetails,
//     this.areaName,
//     this.areaId,
//     this.boxSize,
//     this.status,
//     this.deliveryStatus,
//     this.pickedAt,
//     this.pickedBy,
//     this.createdAt,
//     this.createdBy,
//     this.updatedAt,
//   });

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
//   String? deliveryStatus;
//   DateTime? pickedAt;
//   int? pickedBy;
//   DateTime? createdAt;
//   int? createdBy;
//   DateTime? updatedAt;

//   factory OrderListData.fromJson(Map<String?, dynamic> json) => OrderListData(
//         id: json["id"] == null ? null : json["id"],
//         boxUniqueId:
//             json["box_unique_id"] == null ? null : json["box_unique_id"],
//         customerId: json["customer_id"] == null ? null : json["customer_id"],
//         customerName:
//             json["customer_name"] == null ? null : json["customer_name"],
//         customerEmail:
//             json["customer_email"] == null ? null : json["customer_email"],
//         customerNumber:
//             json["customer_number"] == null ? null : json["customer_number"],
//         pickupLocation:
//             json["pickup_location"] == null ? null : json["pickup_location"],
//         pickupLatitude:
//             json["pickup_latitude"] == null ? null : json["pickup_latitude"],
//         pickupLongitude:
//             json["pickup_longitude"] == null ? null : json["pickup_longitude"],
//         deliveryAddress:
//             json["delivery_Address"] == null ? null : json["delivery_Address"],
//         deliveryLatitude: json["delivery_latitude"] == null
//             ? null
//             : json["delivery_latitude"],
//         deliveryLongitude: json["delivery_longitude"] == null
//             ? null
//             : json["delivery_longitude"],
//         deliveryDetails:
//             json["delivery_details"] == null ? null : json["delivery_details"],
//         areaName: json["area_name"] == null ? null : json["area_name"],
//         areaId: json["area_id"] == null ? null : json["area_id"],
//         boxSize: json["box_size"] == null ? null : json["box_size"],
//         status: json["status"] == null ? null : json["status"],
//         deliveryStatus:
//             json["delivery_status"] == null ? null : json["delivery_status"],
//         pickedAt: json["picked_at"] == null
//             ? null
//             : DateTime.parse(json["picked_at"]),
//         pickedBy: json["picked_by"] == null ? null : json["picked_by"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         createdBy: json["created_by"] == null ? null : json["created_by"],
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );
// }

class OrderListResponse {
  String? code;
  String? message;
  String? error;
  List<Data>? data;

  OrderListResponse({this.code, this.message, this.error, this.data});

  OrderListResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

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
  int? totalDistanceTravelledKm;
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
    totalDistanceTravelledKm = json['total_distance_travelled_km'];
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
