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

class OrderListResponse {
  OrderListResponse({
    this.code,
    this.message,
    this.error,
    this.data,
  });

  String? code;
  String? message;
  dynamic error;
  List<OrderListData>? data;

  factory OrderListResponse.fromJson(Map<String?, dynamic> json) =>
      OrderListResponse(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        error: json["error"],
        data: json["data"] == null
            ? null
            : List<OrderListData>.from(
                json["data"].map((x) => OrderListData.fromJson(x))),
      );
}

class OrderListData {
  OrderListData({
    this.id,
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
    this.deliveryStatus,
    this.pickedAt,
    this.pickedBy,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
  });

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
  String? deliveryStatus;
  DateTime? pickedAt;
  int? pickedBy;
  DateTime? createdAt;
  int? createdBy;
  DateTime? updatedAt;

  factory OrderListData.fromJson(Map<String?, dynamic> json) => OrderListData(
        id: json["id"] == null ? null : json["id"],
        boxUniqueId:
            json["box_unique_id"] == null ? null : json["box_unique_id"],
        customerId: json["customer_id"] == null ? null : json["customer_id"],
        customerName:
            json["customer_name"] == null ? null : json["customer_name"],
        customerEmail:
            json["customer_email"] == null ? null : json["customer_email"],
        customerNumber:
            json["customer_number"] == null ? null : json["customer_number"],
        pickupLocation:
            json["pickup_location"] == null ? null : json["pickup_location"],
        pickupLatitude:
            json["pickup_latitude"] == null ? null : json["pickup_latitude"],
        pickupLongitude:
            json["pickup_longitude"] == null ? null : json["pickup_longitude"],
        deliveryAddress:
            json["delivery_Address"] == null ? null : json["delivery_Address"],
        deliveryLatitude: json["delivery_latitude"] == null
            ? null
            : json["delivery_latitude"],
        deliveryLongitude: json["delivery_longitude"] == null
            ? null
            : json["delivery_longitude"],
        deliveryDetails:
            json["delivery_details"] == null ? null : json["delivery_details"],
        areaName: json["area_name"] == null ? null : json["area_name"],
        areaId: json["area_id"] == null ? null : json["area_id"],
        boxSize: json["box_size"] == null ? null : json["box_size"],
        status: json["status"] == null ? null : json["status"],
        deliveryStatus:
            json["delivery_status"] == null ? null : json["delivery_status"],
        pickedAt: json["picked_at"] == null
            ? null
            : DateTime.parse(json["picked_at"]),
        pickedBy: json["picked_by"] == null ? null : json["picked_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        createdBy: json["created_by"] == null ? null : json["created_by"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );
}
