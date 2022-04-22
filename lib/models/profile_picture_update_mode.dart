class ProfilePictureUpdateModel {
  String? code;
  String? message;
  Null? error;
  Data? data;

  ProfilePictureUpdateModel({this.code, this.message, this.error, this.data});

  ProfilePictureUpdateModel.fromJson(Map<String, dynamic> json) {
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
  Null? token;
  String? createdAt;
  String? updatedAt;
  Null? createdBy;
  Null? updatedBy;
  int? isDriverOnline;
  int? isDriverBusy;
  Null? currentLat;
  Null? currentLang;

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
      this.currentLang});

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
