import 'package:dio/dio.dart';
import 'package:sendeaze/constants/api-constants.dart';
import 'package:sendeaze/constants/shared-pref-constant.dart';
import 'package:sendeaze/services/common/shared-preference-service.dart';

class DioClient {
  static Dio? _dio;

  static Dio? getClient() {
    if (_dio == null) {
      _dio = Dio(BaseOptions(
        baseUrl: AppApi.APP_BASE_URL,
        validateStatus: (status) {
          return status! <= 500;
        },
        headers: {
          'Accept': 'application/json',
        },
      ));

      _dio?.interceptors
          .add(InterceptorsWrapper(onRequest: (options, handler) async {
        String token = await _loadTokenFromSharedPreference();
        print('Token :::: $token');
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      }, onResponse: (resp, handler) async {
        if (resp.statusCode == 401) {
          String token = await _loadTokenFromSharedPreference();
          if (token != null && token.isNotEmpty) {
            _dio?.interceptors.requestLock.lock();
            _dio?.interceptors.responseLock.lock();
            final String refreshToken = await SharedPref()
                .getDataFromLocal(SharedPrefConstants.refreshToken);
            return new Dio(_dio?.options).post(AppApi.USER_LOGIN, data: {
              "type": "refreshToken",
              "refreshToken": refreshToken,
            }).whenComplete(() {
              _dio?.interceptors.requestLock.unlock();
              _dio?.interceptors.responseLock.unlock();
            }).then((refreshTokenResp) async {
              if (refreshTokenResp.statusCode! >= 200 &&
                  refreshTokenResp.statusCode! <= 300) {
//                _inMemoryToken = refreshTokenResp.data['authToken'];
                await SharedPref().setStringToLocal(
                    SharedPrefConstants.refreshToken,
                    refreshTokenResp.data['authToken']);
                await SharedPref().setStringToLocal(
                    SharedPrefConstants.refreshToken,
                    refreshTokenResp.data['refreshToken']);
                final response = await _dio?.request(resp.requestOptions.path,
                    queryParameters: resp.requestOptions.queryParameters,
                    data: resp.requestOptions.data,
                    options: Options(
                        method: resp.requestOptions.method,
                        sendTimeout: resp.requestOptions.sendTimeout,
                        receiveTimeout: resp.requestOptions.receiveTimeout,
                        extra: resp.requestOptions.extra,
                        headers: resp.requestOptions.headers,
                        responseType: resp.requestOptions.responseType,
                        contentType: resp.requestOptions.contentType,
                        validateStatus: resp.requestOptions.validateStatus,
                        receiveDataWhenStatusError:
                            resp.requestOptions.receiveDataWhenStatusError,
                        followRedirects: resp.requestOptions.followRedirects,
                        maxRedirects: resp.requestOptions.maxRedirects,
                        requestEncoder: resp.requestOptions.requestEncoder,
                        responseDecoder: resp.requestOptions.responseDecoder,
                        listFormat: resp.requestOptions.listFormat));
                return handler.next(response!);
              } else {
                return handler.next(resp);
              }
            }).catchError((error) {
              print(error);
              return handler.next(resp);
            });
          }
        }
        return handler.next(resp);
      }, onError: (DioError error, handler) async {
        return handler.next(error);
      }));
    }
    return _dio;
  }

  static _loadTokenFromSharedPreference() async {
    var accessToken = '';
    final String token =
        await SharedPref().getDataFromLocal(SharedPrefConstants.token);
    // If user is already authenticated, we can load his token from cache
    if (token != null) {
      accessToken = token;
    }
    return accessToken;
  }
}
