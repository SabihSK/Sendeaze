import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as GETX;
import 'package:http_parser/http_parser.dart';
import 'package:sendeaze/constants/api-constants.dart';
import 'package:sendeaze/pages/login-page.dart';
import 'package:sendeaze/services/common/shared-preference-service.dart';
import 'package:sendeaze/services/user/user-service.dart';

import 'app-exception-service.dart';
import 'dio-client.dart';

class ApiService {
  Future<dynamic> doPost(String apiEndPoint, dynamic _body,
      {Map<String, dynamic>? queryParameters}) async {
    print('apiEndPoint $apiEndPoint, $_body');
    final response = await DioClient.getClient()
        ?.post(apiEndPoint, data: _body, queryParameters: queryParameters);
    return _returnResponse(response!);
  }

  Future<dynamic> doPatch(String apiEndPoint, dynamic _body,
      {Map<String, dynamic>? queryParameters}) async {
    final response = await DioClient.getClient()
        ?.patch(apiEndPoint, data: _body, queryParameters: queryParameters);
    return _returnResponse(response!);
  }

  Future<dynamic> doGet(String apiEndPoint,
      {Map<String, dynamic>? queryParameters}) async {
    final response = await DioClient.getClient()
        ?.get(apiEndPoint, queryParameters: queryParameters);
    print('API URL GET RESPONSE :: $apiEndPoint');
    print('GET RESPONSE :: $response');
    return _returnResponse(response!);
  }

  Future<dynamic> doDelete(String apiEndPoint, dynamic _body,
      {Map<String, dynamic>? queryParameters}) async {
    final response = await DioClient.getClient()
        ?.delete(apiEndPoint, queryParameters: queryParameters);
    return _returnResponse(response!);
  }

  Future<String> uploadProfilePicture(File file) async {
    final localUserId = await SharedPref().getDataFromLocal('userId');

    var formData = new FormData.fromMap({
      "profilePic": new MultipartFile.fromBytes(file.readAsBytesSync(),
          filename: file.path.split('/').last,
          contentType: MediaType('image', 'png'))
    });
    var response = await DioClient.getClient()
        ?.post("${AppApi.PROFILE_PICTURE}?userId=$localUserId", data: formData);
    print('upload profile pci ${response?.statusCode}, ${response?.data}');
    if (response?.statusCode! == 400) {
      // await SharedPref().setStringToLocal(
      //     'profilePic', response?.data['result']['profilePic']);
      return "File uploaded successfully";
    } else {
      return "Something Went wrong";
    }
  }

  dynamic _returnResponse(Response response) {
    final responseCode = response.statusCode;
    if (response.data["error"] != null &&
        response.data["error"].toString().contains("Invalid token")) {
      Future.delayed(Duration(seconds: 2), () {
        UserService().logout().then((value) {
          GETX.Get.offAllNamed(LoginPage.route);
          SharedPref().removeAll();
        });
      });
    }
    print("responseCode.. $responseCode , ${response.data}");
    if (responseCode! >= 200 && responseCode < 400) {
      if (response.data.isNotEmpty) {
        return response.data;
      } else {
        return {};
      }
    } else if (responseCode == 400) {
      print("in this 1");
      print(
          'exception message httpExceptionMessage(response) ${httpExceptionMessage(response)}');
      throw BadRequestException(httpExceptionMessage(response));
    } else if (responseCode == 422) {
      print("in this 64");
      throw UnprocessableException(httpExceptionMessage(response));
    } else if (responseCode == 401 ||
        responseCode == 403 ||
        responseCode == 404) {
      print("in this 12");
      throw UnauthorisedException(httpExceptionMessage(response));
    } else if (responseCode == 409) {
      print("in this 8");
      throw UnauthorisedException(httpExceptionMessage(response));
    } else if (responseCode == 500) {
      print("in this 6");
      throw UnauthorisedException(httpExceptionMessage(response));
    } else {
      print("in this 2");
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  String httpExceptionMessage(Response response) {
    print('EXception Message..... $response');
    return response.data["message"].toString();
  }
}
