class LoginResponse {
  LoginResponse({
    this.code,
    this.message,
    this.error,
    this.data,
  });

  String? code;
  String? message;
  dynamic error;
  LoginData? data;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        error: json["error"],
        data: json["data"] == null ? null : LoginData.fromJson(json["data"]),
      );
}

class LoginData {
  LoginData({
    this.id,
    this.name,
    this.email,
    this.validationToken,
    this.emailVerifiedAt,
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
    this.assignedAreas,
  });

  int? id;
  String? name;
  String? email;
  String? validationToken;
  DateTime? emailVerifiedAt;
  String? iqNum;
  DateTime? dob;
  String? medicalNum;
  var licenseNum;
  dynamic lExpireNum;
  String? mobileNum;
  dynamic address;
  String? profileImg;
  int? status;
  String? token;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<AssignedArea>? assignedAreas;

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        validationToken:
            json["validation_token"] == null ? null : json["validation_token"],
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        iqNum: json["iq_num"] == null ? null : json["iq_num"],
//    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        medicalNum: json["medical_num"] == null ? null : json["medical_num"],
        licenseNum: json["license_num"] == null ? null : json["license_num"],
        // lExpireNum: json["l_expire_num"] == null
        //     ? null
        //     : DateTime.parse(json["l_expire_num"]),
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
        assignedAreas: json["assigned_areas"] == null
            ? null
            : List<AssignedArea>.from(
                json["assigned_areas"].map((x) => AssignedArea.fromJson(x))),
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

  factory AssignedArea.fromJson(Map<String, dynamic> json) => AssignedArea(
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

  Map<String, dynamic> toJson() => {
        "area_name": areaName == null ? null : areaName,
        "id": id == null ? null : id,
        "driver_id": driverId == null ? null : driverId,
        "area_id": areaId == null ? null : areaId,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
      };
}
