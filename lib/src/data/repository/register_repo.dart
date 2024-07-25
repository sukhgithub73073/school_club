import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school_club/src/data/models/response_model.dart';
import 'package:school_club/src/data/network/api_status_code.dart';
import 'package:school_club/src/data/network/http_service.dart';

abstract class RegisterRepository {
  Future<ResponseModel> registerApi(Map<String, dynamic> body);

  Future<ResponseModel> getDisablity(Map<String, dynamic> body);

  Future<ResponseModel> getCastListApi();

  Future<ResponseModel> getSerialNoApi();
}

class RegisterRepositoryImp extends RegisterRepository {
  @override
  Future<ResponseModel> registerApi(Map<String, dynamic> body) async {
    var responseModel =
        await ResponseModel(status: "", data: null, errors: null, message: "");
    responseModel = await HttpService().postRequest(
        fullUrl: ApisEndpoints.createStudentUrl,
        body: body,
        useTokenInBody: true);
    return responseModel;
  }

  @override
  Future<ResponseModel> getCastListApi() async {
    var res = await HttpService()
        .getRequest(fullUrl: ApisEndpoints.getCasteUrl, useTokenInBody: true);

    return res;
  }

  @override
  Future<ResponseModel> getDisablity(Map<String, dynamic> body) async {
    var res = await HttpService().getRequest(
        fullUrl: ApisEndpoints.getDisabilityUrl, useTokenInBody: true);

    return res;
  }

  @override
  Future<ResponseModel> getSerialNoApi() async {
    var res = await HttpService().getRequestWithForm(
        fullUrl: "${ApisEndpoints.getSerialNoUrl}4", useTokenInBody: true);
    return res;
  }
}
