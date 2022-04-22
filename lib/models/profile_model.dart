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

// class ProfileModel {
//   ProfileModel({
//     this.code,
//     this.message,
//     this.error,
//     this.data,
//   });

//   String? code;
//   String? message;
//   dynamic error;
//   ProfileData? data;

//   factory ProfileModel.fromJson(Map<String?, dynamic> json) => ProfileModel(
//         code: json["code"] == null ? null : json["code"],
//         message: json["message"] == null ? null : json["message"],
//         error: json["error"],
//         data: json["data"] == null ? null : ProfileData.fromJson(json["data"]),
//       );
// }

// class ProfileData {
//   ProfileData({
//     this.id,
//     this.name,
//     this.email,
//     this.validationToken,
//     this.firebaseToken,
//     this.emailVerifiedAt,
//     this.verified,
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
//     this.vehicles,
//     this.stats,
//   });

//   int? id;
//   String? name;
//   String? email;
//   String? validationToken;
//   String? firebaseToken;
//   DateTime? emailVerifiedAt;
//   int? verified;
//   String? iqNum;
//   String? dob;
//   String? medicalNum;
//   String? licenseNum;
//   String? lExpireNum;
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
//   List<Vehicle>? vehicles;
//   Stats? stats;

//   factory ProfileData.fromJson(Map<String?, dynamic> json) => ProfileData(
//         id: json["id"] == null ? null : json["id"],
//         name: json["name"] == null ? null : json["name"],
//         email: json["email"] == null ? null : json["email"],
//         validationToken:
//             json["validation_token"] == null ? null : json["validation_token"],
//         firebaseToken:
//             json["firebase_token"] == null ? null : json["firebase_token"],
//         emailVerifiedAt: json["email_verified_at"] == null
//             ? null
//             : DateTime.parse(json["email_verified_at"]),
//         verified: json["verified"] == null ? null : json["verified"],
//         iqNum: json["iq_num"] == null ? null : json["iq_num"],
//         dob: json["dob"] == null ? null : json["dob"],
//         medicalNum: json["medical_num"] == null ? null : json["medical_num"],
//         licenseNum: json["license_num"] == null ? null : json["license_num"],
//         lExpireNum: json["l_expire_num"] == null ? null : json["l_expire_num"],
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
//         vehicles: json["vehicles"] == null
//             ? null
//             : List<Vehicle>.from(
//                 json["vehicles"].map((x) => Vehicle.fromJson(x))),
//         stats: json["stats"] == null ? null : Stats.fromJson(json["stats"]),
//       );
// }

// class AssignedArea {
//   AssignedArea({
//     this.areaName,
//     this.id,
//     this.driverId,
//     this.areaId,
//     this.createdAt,
//     this.updatedAt,
//   });

//   String? areaName;
//   int? id;
//   int? driverId;
//   int? areaId;
//   DateTime? createdAt;
//   DateTime? updatedAt;

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

// class Stats {
//   Stats({
//     this.totalOrdersDelivered,
//     this.totalTimeSpentMinutes,
//     this.totalRatings,
//   });

//   int? totalOrdersDelivered;
//   var totalTimeSpentMinutes;
//   int? totalRatings;

//   factory Stats.fromJson(Map<String?, dynamic> json) => Stats(
//         totalOrdersDelivered: json["total_orders_delivered"] == null
//             ? null
//             : json["total_orders_delivered"],
//         totalTimeSpentMinutes: json["total_time_spent_minutes"] == null
//             ? null
//             : json["total_time_spent_minutes"],
//         totalRatings:
//             json["total_ratings"] == null ? null : json["total_ratings"],
//       );
// }

// class Vehicle {
//   Vehicle({
//     this.id,
//     this.driverId,
//     this.title,
//     this.carMake,
//     this.carModel,
//     this.carNum,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//   });

//   int? id;
//   int? driverId;
//   String? title;
//   String? carMake;
//   String? carModel;
//   String? carNum;
//   int? status;
//   DateTime? createdAt;
//   DateTime? updatedAt;

//   factory Vehicle.fromJson(Map<String?, dynamic> json) => Vehicle(
//         id: json["id"] == null ? null : json["id"],
//         driverId: json["driver_id"] == null ? null : json["driver_id"],
//         title: json["title"] == null ? null : json["title"],
//         carMake: json["car_make"] == null ? null : json["car_make"],
//         carModel: json["car_model"] == null ? null : json["car_model"],
//         carNum: json["car_num"] == null ? null : json["car_num"],
//         status: json["status"] == null ? null : json["status"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );
// }
class ProfileModel {
  String? code;
  String? message;
  String? error;
  Data? data;

  ProfileModel({this.code, this.message, this.error, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
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
  List<AssignedAreas>? assignedAreas;
  List<Vehicles>? vehicles;
  Stats? stats;

  Data(
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
      this.currentLang,
      this.assignedAreas,
      this.vehicles,
      this.stats});

  Data.fromJson(Map<String, dynamic> json) {
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
    if (json['assigned_areas'] != null) {
      assignedAreas = <AssignedAreas>[];
      json['assigned_areas'].forEach((v) {
        assignedAreas!.add(new AssignedAreas.fromJson(v));
      });
    }
    if (json['vehicles'] != null) {
      vehicles = <Vehicles>[];
      json['vehicles'].forEach((v) {
        vehicles!.add(new Vehicles.fromJson(v));
      });
    }
    stats = json['stats'] != null ? new Stats.fromJson(json['stats']) : null;
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
    if (this.assignedAreas != null) {
      data['assigned_areas'] =
          this.assignedAreas!.map((v) => v.toJson()).toList();
    }
    if (this.vehicles != null) {
      data['vehicles'] = this.vehicles!.map((v) => v.toJson()).toList();
    }
    if (this.stats != null) {
      data['stats'] = this.stats!.toJson();
    }
    return data;
  }
}

class AssignedAreas {
  String? areaName;
  int? id;
  int? driverId;
  int? areaId;
  String? createdAt;
  String? updatedAt;

  AssignedAreas(
      {this.areaName,
      this.id,
      this.driverId,
      this.areaId,
      this.createdAt,
      this.updatedAt});

  AssignedAreas.fromJson(Map<String, dynamic> json) {
    areaName = json['area_name'];
    id = json['id'];
    driverId = json['driver_id'];
    areaId = json['area_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['area_name'] = this.areaName;
    data['id'] = this.id;
    data['driver_id'] = this.driverId;
    data['area_id'] = this.areaId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Vehicles {
  int? id;
  int? driverId;
  String? title;
  String? carMake;
  String? carModel;
  String? carNum;
  int? alreadyDrivenKm;
  String? istamaraPicture;
  String? istamaraExpiry;
  String? insuranceNumber;
  String? insuranceExpiry;
  String? lastServiceDate;
  int? status;
  String? createdAt;
  String? updatedAt;
  Null? createdBy;
  Null? updatedBy;

  Vehicles(
      {this.id,
      this.driverId,
      this.title,
      this.carMake,
      this.carModel,
      this.carNum,
      this.alreadyDrivenKm,
      this.istamaraPicture,
      this.istamaraExpiry,
      this.insuranceNumber,
      this.insuranceExpiry,
      this.lastServiceDate,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy});

  Vehicles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    driverId = json['driver_id'];
    title = json['title'];
    carMake = json['car_make'];
    carModel = json['car_model'];
    carNum = json['car_num'];
    alreadyDrivenKm = json['already_driven_km'];
    istamaraPicture = json['istamara_picture'];
    istamaraExpiry = json['istamara_expiry'];
    insuranceNumber = json['insurance_number'];
    insuranceExpiry = json['insurance_expiry'];
    lastServiceDate = json['last_service_date'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['driver_id'] = this.driverId;
    data['title'] = this.title;
    data['car_make'] = this.carMake;
    data['car_model'] = this.carModel;
    data['car_num'] = this.carNum;
    data['already_driven_km'] = this.alreadyDrivenKm;
    data['istamara_picture'] = this.istamaraPicture;
    data['istamara_expiry'] = this.istamaraExpiry;
    data['insurance_number'] = this.insuranceNumber;
    data['insurance_expiry'] = this.insuranceExpiry;
    data['last_service_date'] = this.lastServiceDate;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}

class Stats {
  int? totalOrdersDeliveredAll;
  int? totalOrdersDeliveredToday;
  String? timeSpentMinutesAll;
  String? timeSpentMinutesToday;
  String? distanceTravelledKmAll;
  String? distanceTravelledKmToday;
  int? totalRatings;

  Stats(
      {this.totalOrdersDeliveredAll,
      this.totalOrdersDeliveredToday,
      this.timeSpentMinutesAll,
      this.timeSpentMinutesToday,
      this.distanceTravelledKmAll,
      this.distanceTravelledKmToday,
      this.totalRatings});

  Stats.fromJson(Map<String, dynamic> json) {
    totalOrdersDeliveredAll = json['total_orders_delivered_all'];
    totalOrdersDeliveredToday = json['total_orders_delivered_today'];
    timeSpentMinutesAll = json['time_spent_minutes_all'];
    timeSpentMinutesToday = json['time_spent_minutes_today'];
    distanceTravelledKmAll = json['distance_travelled_km_all'];
    distanceTravelledKmToday = json['distance_travelled_km_today'];
    totalRatings = json['total_ratings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_orders_delivered_all'] = this.totalOrdersDeliveredAll;
    data['total_orders_delivered_today'] = this.totalOrdersDeliveredToday;
    data['time_spent_minutes_all'] = this.timeSpentMinutesAll;
    data['time_spent_minutes_today'] = this.timeSpentMinutesToday;
    data['distance_travelled_km_all'] = this.distanceTravelledKmAll;
    data['distance_travelled_km_today'] = this.distanceTravelledKmToday;
    data['total_ratings'] = this.totalRatings;
    return data;
  }
}
