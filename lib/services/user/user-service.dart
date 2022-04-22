import 'dart:convert';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import 'package:sendeaze/constants/api-constants.dart';
import 'package:sendeaze/constants/shared-pref-constant.dart';
import 'package:sendeaze/models/login-response.dart';
import 'package:sendeaze/models/profile_model.dart';
import 'package:sendeaze/models/profile_picture_update_mode.dart';
import 'package:sendeaze/models/report_issue_model.dart';
import 'package:sendeaze/pages/home-page.dart';
import 'package:sendeaze/services/common/api-services.dart';
import 'package:sendeaze/services/common/shared-preference-service.dart';
import 'package:sendeaze/widgets/app-widgets.dart';
import 'package:sendeaze/widgets/statistics-card.dart';

class UserService {
  Future<LoginResponse> doLogin(String email, String password, token) async {
    print(token);
    final body = {
      "email": "$email",
      "password": password,
      "firebase_token": token
    };
    final httpJson = await ApiService().doPost(AppApi.USER_LOGIN, body);
    LoginResponse response = LoginResponse.fromJson(httpJson);
    // if (response.error != null) {
    //   AppWidgets.showSnackBar(response.error.toString());
    // }
    print("${response.code}");
    if (response.code != null && response.code == "200") {
      await SharedPref().setStringToLocal(
          SharedPrefConstants.USER_EMAIL, response.data!.email!);
      await SharedPref()
          .setStringToLocal(SharedPrefConstants.NAME, response.data!.name!);
      await SharedPref().setStringToLocal(
          SharedPrefConstants.driver_id, response.data!.id.toString());
      await SharedPref().setStringToLocal(
          SharedPrefConstants.token, response.data!.validationToken!);

      await SharedPref().setStringToLocal(
          SharedPrefConstants.USER_PROFILE_IMAGE, response.data!.profileImg!);

      await SharedPref().setBoolToLocal("rememberMe", true);
      // bool rememeber =
      //    await SharedPref().getBoolFromLocal("rememberMe");
      // print("rember me $rememeber");

      //?---
      final dbrEf = FirebaseDatabase.instance.ref();

      await dbrEf
          .child("driverToken/${response.data!.id}")
          .update({"driverToken": token});

      Get.toNamed(HomePage.route);
    }
    return response;
  }

  Future uploadImageFunc(picture) async {
    String token =
        await SharedPref().getDataFromLocal(SharedPrefConstants.token);
    String driverId =
        await SharedPref().getDataFromLocal(SharedPrefConstants.driver_id);
    try {
      final body = {
        'validation_token': '$token',
        'driver_id': '$driverId',
        'profile_picture': '$picture'
      };
      final httpJson = await ApiService().doPost(AppApi.UPDATE_PICTURE, body);
      ProfilePictureUpdateModel response =
          ProfilePictureUpdateModel.fromJson(httpJson);
      if (response.error != null) {
        AppWidgets.showSnackBar(response.error.toString());
      }
      if (response.code != null && response.code == "200") {
        AppWidgets.showSnackBar(response.message ?? "Please reupload image");
        await SharedPref().setStringToLocal(
            SharedPrefConstants.USER_PROFILE_IMAGE, response.data!.profileImg!);

        return response;
      }
    } catch (e) {
      AppWidgets.showSnackBar(e.toString());
    }
  }

  Future forgotPassword(String email) async {
    try {
      final body = {"email": "$email"};
      final httpJson = await ApiService().doPost(AppApi.FORGOT_PASSWORD, body);
      LoginResponse response = LoginResponse.fromJson(httpJson);
      if (response.error != null) {
        AppWidgets.showSnackBar(response.error.toString());
      }
      if (response.code != null && response.code == "200") {
        AppWidgets.showSnackBar(response.message ?? "Please check email");
      }
      return response;
    } catch (e) {
      AppWidgets.showSnackBar(e.toString());
    }
  }

  Future changePassword(String currentPAssword, String newPassword) async {
    String token =
        await SharedPref().getDataFromLocal(SharedPrefConstants.token);
    String driverId =
        await SharedPref().getDataFromLocal(SharedPrefConstants.driver_id);

    try {
      final body = {
        "current_password": "$currentPAssword",
        "new_password": "$newPassword",
        "validation_token": token,
        "driver_id": int.parse(driverId),
      };
      final httpJson = await ApiService().doPost(AppApi.CHANGE_PASSWORD, body);
      LoginResponse response = LoginResponse.fromJson(httpJson);
      if (response.error != null) {
        AppWidgets.showSnackBar(response.error.toString());
      }
      if (response.code != null && response.code == "200") {
        AppWidgets.showSnackBar(response.message ?? "Something went wrong");
      }
      return response;
    } catch (e) {
      AppWidgets.showSnackBar(e.toString());
    }
  }

  Future<ProfileModel> getProfile() async {
    String token =
        await SharedPref().getDataFromLocal(SharedPrefConstants.token);
    String driverId =
        await SharedPref().getDataFromLocal(SharedPrefConstants.driver_id);
    final body = {
      "validation_token": token,
      "driver_id": int.parse(driverId),
    };
    print("body $body");
    final httpJson = await ApiService().doPost(AppApi.GET_PROFILE, body);
    ProfileModel response = ProfileModel.fromJson(httpJson);
    if (response.error != null) {
      AppWidgets.showSnackBar(response.error.toString());
    }
    if (response.code != null && response.code == "200") {
      return response;
    }
    return response;
  }

  Future<ProfileModel> updateProfile(
      {String? name,
      var idNum,
      licenceNum,
      mobileNum,
      medicalNum,
      var dob,
      licenceExpiry}) async {
    String token =
        await SharedPref().getDataFromLocal(SharedPrefConstants.token);
    String driverId =
        await SharedPref().getDataFromLocal(SharedPrefConstants.driver_id);
    final body = {
      "validation_token": token,
      "driver_id": int.parse(driverId),
      "name": name,
      "id_number": idNum,
      "dob": dob,
      "medical_number": medicalNum,
      "license_number": licenceNum,
      "license_expiry": licenceExpiry,
      "mobile_number": mobileNum,
    };
    print("body $body");
    final httpJson = await ApiService().doPost(AppApi.GET_PROFILE, body);
    ProfileModel response = ProfileModel.fromJson(httpJson);
    if (response.error != null) {
      AppWidgets.showSnackBar(response.error.toString());
    }
    if (response.code != null && response.code == "200") {
      return response;
    }
    return response;
  }

  Future<dynamic> reportIssue(subject, content) async {
    String token =
        await SharedPref().getDataFromLocal(SharedPrefConstants.token);
    String driverId =
        await SharedPref().getDataFromLocal(SharedPrefConstants.driver_id);
    final body = {
      "validation_token": token,
      "subject": subject,
      "content": content,
      "driver_id": int.parse(driverId),
    };
    print("body $body");
    final httpJson = await ApiService().doPost(AppApi.REPORT_ISSUE, body);
    ReportIssueModel response = ReportIssueModel.fromJson(httpJson);
    if (response.error != null) {
      AppWidgets.showSnackBar(response.error.toString());
    }
    if (response.code != null && response.code == "200") {
      AppWidgets.showSnackBar(response.message);

      return response;
    }
    return response;
  }

  Future<ProfileModel> logout() async {
    String token =
        await SharedPref().getDataFromLocal(SharedPrefConstants.token);
    String driverId =
        await SharedPref().getDataFromLocal(SharedPrefConstants.driver_id);
    final body = {
      "validation_token": token,
      "driver_id": int?.parse(driverId),
    };
    print("body $body");
    final httpJson = await ApiService().doPost(AppApi.LOGOUT, body);
    ProfileModel response = ProfileModel.fromJson(httpJson);
    if (response.error != null) {
      AppWidgets.showSnackBar(response.error.toString());
    }
    if (response.code != null && response.code == "200") {
      return response;
    }
    return response;
  }

  Future<String> uploadProfilePic(File file) async {
    final httpJson = await ApiService().uploadProfilePicture(file);
    print("httpJson uploadProfilePic $httpJson");
    return httpJson;
  }
}
