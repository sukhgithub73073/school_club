import 'dart:io';

import 'package:dio/dio.dart';
import 'package:school_club/src/data/models/response_model.dart';
import 'package:school_club/src/data/network/api_status_code.dart';
import 'package:school_club/src/utility/app_util.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_parser/http_parser.dart';

part 'api_endpoints.dart';

part 'exceptions.dart';

abstract class HttpServiceConst {

}

class HttpService {
  late Dio _dio;

  HttpService() {
    _dio = Dio();
  }

  Future<ResponseModel> getRequest({
    required String fullUrl,
    bool useTokenInBody = true,
  }) async {
    ResponseModel responseModel = ResponseModel(status: "",data: null,errors: null,message: "") ;
    Response response;
    try {
      printLog("Hit Api Url 😛 ==> $fullUrl");
      printLog("Hit Request Type 😛 ==> get");
      var headers = {
        'X-API-Key': 'ahscfSsMbWHe0jZUs80AFRpEom1mo/qgkFb9YRLt6fg=',
        "Authorization" : "Bearer "
      };

      if(useTokenInBody){

      }
      response = await _dio.get(
        fullUrl,
        options: Options(headers: {}),
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
    ResponseModel responseModel = ResponseModel(status: "",data: null,errors: null,message: "") ;

    var headers = {
      'X-API-Key': 'ahscfSsMbWHe0jZUs80AFRpEom1mo/qgkFb9YRLt6fg='
    };

    var data = FormData.fromMap(body) ;
    var dio = Dio();
    Response response = await dio.request(
      fullUrl,
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    responseModel =ResponseModel.fromJson(response.data) ;
    printLog("Dio asdasdddas : ${responseModel.status}><><>>>>>>>>>>>");

    if (response.statusCode == 200) {
      printLog("Dio Response : $fullUrl ${response.data["status"]}");
    }
    else {
      print(response.statusMessage);
      blocLog(bloc: "Error message for", msg: "${response.statusMessage}");
    }



    // try {
    //   var headers = getHeaders() ;
    //   printLog("Hit Api Url 😛 ==> $fullUrl");
    //   printLog("Hit Request Type 😛 ==> POST");
    //   printLog("Hit Body 😛 ==> ${body.toString()}") ;
    //   printLog("Hit Headers 😛 ==> ${headers.toString()}") ;
    //   response = await _dio.post(
    //     fullUrl,
    //     data: body,
    //     options: Options(headers: headers),
    //   );
    //
    //   printLog("Dio Response : $fullUrl ${response}");
    //   responseModel = response.data;
    // } on DioException catch (e) {
    //   blocLog(bloc: "Error message for", msg: "$fullUrl: ${e.message}");
    //   blocLog(bloc: "Error response for $fullUrl ", msg: "${e.response?.data}");
    //   blocLog(bloc: "Error Status Code ", msg: "${e.response?.statusCode}");
    // }
    return responseModel;
  }


  Map<String, String> getHeaders() {
    Map<String, String> headers = {
      "X-API-Key": "ahscfSsMbWHe0jZUs80AFRpEom1mo/qgkFb9YRLt6fg="
    };
    return headers;
  }
}
