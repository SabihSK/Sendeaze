// class ProfileModel {
//   ProfileModel({
//     this.code,
//     this.message,
//     this.error,
//     this.data,
//   });
//
//   String? code;
//   String? message;
//   dynamic error;
//   ProfileData? data;
//
//   factory ProfileModel.fromJson(Map<String?, dynamic> json) => ProfileModel(
//         code: json["code"] == null ? null : json["code"],
//         message: json["message"] == null ? null : json["message"],
//         error: json["error"],
//         data: json["data"] == null ? null : ProfileData.fromJson(json["data"]),
//       );
// }
//
// class ProfileData {
//   ProfileData({
//     this.id,
//     this.name,
//     this.email,
//     this.validationToken,
//     this.emailVerifiedAt,
//     this.iqNum,
//     this.dob,
//     this.medicalNum,
//     this.licenseNum,
//     this.lExpireNum,
//     this.mobileNum,
//     this.address,
//     this.profileImg,
//     this.status,
//     this.token,
//     this.createdAt,
//     this.updatedAt,
//     this.isDriverOnline,
//     this.isDriverBusy,
//     this.currentLat,
//     this.currentLang,
//     this.assignedAreas,
//   });
//
//   int? id;
//   String? name;
//   String? email;
//   String? validationToken;
//   DateTime? emailVerifiedAt;
//   String? iqNum;
//   DateTime? dob;
//   String? medicalNum;
//   DateTime? licenseNum;
//   DateTime? lExpireNum;
//   String? mobileNum;
//   dynamic address;
//   String? profileImg;
//   int? status;
//   String? token;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   int? isDriverOnline;
//   int? isDriverBusy;
//   double? currentLat;
//   double? currentLang;
//   List<AssignedArea>? assignedAreas;
//
//   factory ProfileData.fromJson(Map<String?, dynamic> json) => ProfileData(
//         id: json["id"] == null ? null : json["id"],
//         name: json["name"] == null ? null : json["name"],
//         email: json["email"] == null ? null : json["email"],
//         validationToken:
//             json["validation_token"] == null ? null : json["validation_token"],
//         emailVerifiedAt: json["email_verified_at"] == null
//             ? null
//             : DateTime.parse(json["email_verified_at"]),
//         iqNum: json["iq_num"] == null ? null : json["iq_num"],
//         dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
//         medicalNum: json["medical_num"] == null ? null : json["medical_num"],
//         licenseNum: json["license_num"] == null
//             ? null
//             : DateTime.parse(json["license_num"]),
//         lExpireNum: json["l_expire_num"] == null
//             ? null
//             : DateTime.parse(json["l_expire_num"]),
//         mobileNum: json["mobile_num"] == null ? null : json["mobile_num"],
//         address: json["address"],
//         profileImg: json["profile_img"] == null ? null : json["profile_img"],
//         status: json["status"] == null ? null : json["status"],
//         token: json["token"] == null ? null : json["token"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         isDriverOnline:
//             json["is_driver_online"] == null ? null : json["is_driver_online"],
//         isDriverBusy:
//             json["is_driver_busy"] == null ? null : json["is_driver_busy"],
//         currentLat:
//             json["current_lat"] == null ? null : json["current_lat"].toDouble(),
//         currentLang: json["current_lang"] == null
//             ? null
//             : json["current_lang"].toDouble(),
//         assignedAreas: json["assigned_areas"] == null
//             ? null
//             : List<AssignedArea>.from(
//                 json["assigned_areas"].map((x) => AssignedArea.fromJson(x))),
//       );
// }
//
// class AssignedArea {
//   AssignedArea({
//     this.areaName,
//     this.id,
//     this.driverId,
//     this.areaId,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   String? areaName;
//   int? id;
//   int? driverId;
//   int? areaId;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   factory AssignedArea.fromJson(Map<String?, dynamic> json) => AssignedArea(
//         areaName: json["area_name"] == null ? null : json["area_name"],
//         id: json["id"] == null ? null : json["id"],
//         driverId: json["driver_id"] == null ? null : json["driver_id"],
//         areaId: json["area_id"] == null ? null : json["area_id"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );
// }

class ProfileModel {
  ProfileModel({
    this.code,
    this.message,
    this.error,
    this.data,
  });

  String? code;
  String? message;
  dynamic error;
  ProfileData? data;

  factory ProfileModel.fromJson(Map<String?, dynamic> json) => ProfileModel(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        error: json["error"],
        data: json["data"] == null ? null : ProfileData.fromJson(json["data"]),
      );
}

class ProfileData {
  ProfileData({
    this.id,
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
    this.isDriverOnline,
    this.isDriverBusy,
    this.currentLat,
    this.currentLang,
    this.assignedAreas,
    this.vehicles,
    this.stats,
  });

  int? id;
  String? name;
  String? email;
  String? validationToken;
  String? firebaseToken;
  DateTime? emailVerifiedAt;
  int? verified;
  String? iqNum;
  String? dob;
  String? medicalNum;
  String? licenseNum;
  String? lExpireNum;
  String? mobileNum;
  dynamic address;
  String? profileImg;
  int? status;
  String? token;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? isDriverOnline;
  int? isDriverBusy;
  double? currentLat;
  double? currentLang;
  List<AssignedArea>? assignedAreas;
  List<Vehicle>? vehicles;
  Stats? stats;

  factory ProfileData.fromJson(Map<String?, dynamic> json) => ProfileData(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        validationToken:
            json["validation_token"] == null ? null : json["validation_token"],
        firebaseToken:
            json["firebase_token"] == null ? null : json["firebase_token"],
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        verified: json["verified"] == null ? null : json["verified"],
        iqNum: json["iq_num"] == null ? null : json["iq_num"],
        dob: json["dob"] == null ? null : json["dob"],
        medicalNum: json["medical_num"] == null ? null : json["medical_num"],
        licenseNum: json["license_num"] == null ? null : json["license_num"],
        lExpireNum: json["l_expire_num"] == null ? null : json["l_expire_num"],
        mobileNum: json["mobile_num"] == null ? null : json["mobile_num"],
        address: json["address"],
        profileImg: json["profile_img"] == null ? null : json["profile_img"],
        status: json["status"] == null ? null : json["status"],
        token: json["token"] == null ? null : json["token"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        isDriverOnline:
            json["is_driver_online"] == null ? null : json["is_driver_online"],
        isDriverBusy:
            json["is_driver_busy"] == null ? null : json["is_driver_busy"],
        currentLat:
            json["current_lat"] == null ? null : json["current_lat"].toDouble(),
        currentLang: json["current_lang"] == null
            ? null
            : json["current_lang"].toDouble(),
        assignedAreas: json["assigned_areas"] == null
            ? null
            : List<AssignedArea>.from(
                json["assigned_areas"].map((x) => AssignedArea.fromJson(x))),
        vehicles: json["vehicles"] == null
            ? null
            : List<Vehicle>.from(
                json["vehicles"].map((x) => Vehicle.fromJson(x))),
        stats: json["stats"] == null ? null : Stats.fromJson(json["stats"]),
      );
}

class AssignedArea {
  AssignedArea({
    this.areaName,
    this.id,
    this.driverId,
    this.areaId,
    this.createdAt,
    this.updatedAt,
  });

  String? areaName;
  int? id;
  int? driverId;
  int? areaId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory AssignedArea.fromJson(Map<String?, dynamic> json) => AssignedArea(
        areaName: json["area_name"] == null ? null : json["area_name"],
        id: json["id"] == null ? null : json["id"],
        driverId: json["driver_id"] == null ? null : json["driver_id"],
        areaId: json["area_id"] == null ? null : json["area_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );
}

class Stats {
  Stats({
    this.totalOrdersDelivered,
    this.totalTimeSpentMinutes,
    this.totalRatings,
  });

  int? totalOrdersDelivered;
  var totalTimeSpentMinutes;
  int? totalRatings;

  factory Stats.fromJson(Map<String?, dynamic> json) => Stats(
        totalOrdersDelivered: json["total_orders_delivered"] == null
            ? null
            : json["total_orders_delivered"],
        totalTimeSpentMinutes: json["total_time_spent_minutes"] == null
            ? null
            : json["total_time_spent_minutes"],
        totalRatings:
            json["total_ratings"] == null ? null : json["total_ratings"],
      );
}

class Vehicle {
  Vehicle({
    this.id,
    this.driverId,
    this.title,
    this.carMake,
    this.carModel,
    this.carNum,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? driverId;
  String? title;
  String? carMake;
  String? carModel;
  String? carNum;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Vehicle.fromJson(Map<String?, dynamic> json) => Vehicle(
        id: json["id"] == null ? null : json["id"],
        driverId: json["driver_id"] == null ? null : json["driver_id"],
        title: json["title"] == null ? null : json["title"],
        carMake: json["car_make"] == null ? null : json["car_make"],
        carModel: json["car_model"] == null ? null : json["car_model"],
        carNum: json["car_num"] == null ? null : json["car_num"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );
}
