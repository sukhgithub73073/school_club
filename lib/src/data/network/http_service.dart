import 'dart:io';

import 'package:dio/dio.dart';
import 'package:school_club/src/data/models/response_model.dart';
import 'package:school_club/src/data/network/api_status_code.dart';
import 'package:school_club/src/utility/app_data.dart';
import 'package:school_club/src/utility/app_util.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_parser/http_parser.dart';

part 'api_endpoints.dart';

part 'exceptions.dart';

abstract class HttpServiceConst {}

class HttpService {
  late Dio _dio;

  HttpService() {
    _dio = Dio();
  }

  Future<ResponseModel> getRequestWithForm({
    required String fullUrl,
    bool useTokenInBody = true,
  }) async {
    ResponseModel responseModel =
        ResponseModel(status: "", data: null, errors: null, message: "");
    Response response;
    try {
      var headers = {
        'Authorization': 'Bearer ${AppData.authToken}',
        'Content-Type': 'multipart/form-data',
        'X-API-Key': 'ahscfSsMbWHe0jZUs80AFRpEom1mo/qgkFb9YRLt6fg='
      };
      var data = FormData.fromMap({
        'college_id': '${AppData.userModel.data?.data.college.id ?? ""}',
        'session': '2023'
      });
      printLog("Hit Api Url 😛 ==> $fullUrl");
      printLog("Hit Request Type 😛 ==> get");
      printLog("Hit Request Type 😛headers ==> headers>>>${headers}");

      var dio = Dio();
      var response = await dio.request(
        fullUrl,
        options: Options(
          method: 'GET',
          headers: headers,
        ),
        data: data,
      );
      printLog("Dio Response : $fullUrl ${response.data}");
      responseModel.data = response.data;
    } on SocketException catch (e) {
      blocLog(bloc: "Error message for", msg: "$fullUrl: ${e.message}");
      blocLog(bloc: "Error Status Code ", msg: "SocketException");
      throw SocketException(e.message);
    } on DioError catch (e) {
      blocLog(bloc: "Error message for", msg: "$fullUrl: ${e.message}");
      blocLog(bloc: "Error response for $fullUrl ", msg: "${e.response?.data}");
      blocLog(bloc: "Error Status Code ", msg: "${e.response?.statusCode}");
    }
    return responseModel;
  }

  Future<ResponseModel> getRequest({
    required String fullUrl,
    bool useTokenInBody = true,
  }) async {
    ResponseModel responseModel =
        ResponseModel(status: "", data: null, errors: null, message: "");
    Response response;
    try {
      var headers = {
        'Authorization': 'Bearer ${AppData.authToken}',
        'X-API-Key': 'ahscfSsMbWHe0jZUs80AFRpEom1mo/qgkFb9YRLt6fg='
      };
      var data = FormData.fromMap({'college_id': '15', 'session': '2023'});
      printLog("Hit Api Url 😛 ==> $fullUrl");
      printLog("Hit Request Type 😛 ==> get");
      printLog("Hit Request Type 😛headers ==> headers>>>${headers}");

      var dio = Dio();
      var response = await dio.request(
        fullUrl,
        options: Options(
          method: 'GET',
          headers: headers,
        ),
        data: data,
      );
      printLog("Dio Response : $fullUrl ${response.data}");
      responseModel.data = response.data;
    } on SocketException catch (e) {
      blocLog(bloc: "Error message for", msg: "$fullUrl: ${e.message}");
      blocLog(bloc: "Error Status Code ", msg: "SocketException");
      throw SocketException(e.message);
    } on DioError catch (e) {
      blocLog(bloc: "Error message for", msg: "$fullUrl: ${e.message}");
      blocLog(bloc: "Error response for $fullUrl ", msg: "${e.response?.data}");
      blocLog(bloc: "Error Status Code ", msg: "${e.response?.statusCode}");
    }
    return responseModel;
  }

  Future<ResponseModel> postRequest({
    required String fullUrl,
    bool useTokenInBody = true,
    required Map<String, dynamic> body,
  }) async {
    ResponseModel responseModel =
        ResponseModel(status: "", data: null, errors: null, message: "");

    var headers = {'X-API-Key': 'ahscfSsMbWHe0jZUs80AFRpEom1mo/qgkFb9YRLt6fg='};
    if (useTokenInBody) {
      headers = {
        'Authorization': 'Bearer ${AppData.authToken}',
        'X-API-Key': 'ahscfSsMbWHe0jZUs80AFRpEom1mo/qgkFb9YRLt6fg='
      };
    }
    printLog("POST Hit Api Url 😛 ==> $fullUrl");
    printLog("POST Hit Request Type 😛 ==> POST");
    printLog("POST Hit Request Type 😛headers ==> headers>>>${headers}");
    printLog("POST Hit Request Type 😛body ==> body>>>${body}");

    var data = FormData.fromMap(body);
    var dio = Dio();
    Response response = await dio.request(
      fullUrl,
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    responseModel = ResponseModel.fromJson(response.data);
    printLog("Dio Response : $fullUrl ${response.data}");
    return responseModel;
  }

  Map<String, String> getHeaders() {
    Map<String, String> headers = {
      "X-API-Key": "ahscfSsMbWHe0jZUs80AFRpEom1mo/qgkFb9YRLt6fg="
    };
    return headers;
  }
}
