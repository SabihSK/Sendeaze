// class LoginResponse {
//   LoginResponse({
//     this.code,
//     this.message,
//     this.error,
//     this.data,
//   });

//   String? code;
//   String? message;
//   dynamic error;
//   LoginData? data;

//   factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
//         code: json["code"] == null ? null : json["code"],
//         message: json["message"] == null ? null : json["message"],
//         error: json["error"],
//         data: json["data"] == null ? null : LoginData.fromJson(json["data"]),
//       );
// }

// class LoginData {
//   LoginData({
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
//     this.assignedAreas,
//   });

//   int? id;
//   String? name;
//   String? email;
//   String? validationToken;
//   DateTime? emailVerifiedAt;
//   String? iqNum;
//   DateTime? dob;
//   String? medicalNum;
//   var licenseNum;
//   dynamic lExpireNum;
//   String? mobileNum;
//   dynamic address;
//   String? profileImg;
//   int? status;
//   String? token;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   List<AssignedArea>? assignedAreas;

//   factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
//         id: json["id"] == null ? null : json["id"],
//         name: json["name"] == null ? null : json["name"],
//         email: json["email"] == null ? null : json["email"],
//         validationToken:
//             json["validation_token"] == null ? null : json["validation_token"],
//         emailVerifiedAt: json["email_verified_at"] == null
//             ? null
//             : DateTime.parse(json["email_verified_at"]),
//         iqNum: json["iq_num"] == null ? null : json["iq_num"],
// //    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
//         medicalNum: json["medical_num"] == null ? null : json["medical_num"],
//         licenseNum: json["license_num"] == null ? null : json["license_num"],
//         // lExpireNum: json["l_expire_num"] == null
//         //     ? null
//         //     : DateTime.parse(json["l_expire_num"]),
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
//         assignedAreas: json["assigned_areas"] == null
//             ? null
//             : List<AssignedArea>.from(
//                 json["assigned_areas"].map((x) => AssignedArea.fromJson(x))),
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

//   factory AssignedArea.fromJson(Map<String, dynamic> json) => AssignedArea(
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

//   Map<String, dynamic> toJson() => {
//         "area_name": areaName == null ? null : areaName,
//         "id": id == null ? null : id,
//         "driver_id": driverId == null ? null : driverId,
//         "area_id": areaId == null ? null : areaId,
//         "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
//         "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
//       };
// }

class LoginResponse {
  String? code;
  String? message;
  Null? error;
  Data? data;

  LoginResponse({this.code, this.message, this.error, this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
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
      this.assignedAreas});

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
