import 'dart:convert';

import 'package:school_club/src/data/models/pincode_model.dart';
import 'package:school_club/src/data/models/response_model.dart';
import 'package:school_club/src/data/network/http_service.dart';
import 'package:school_club/src/utility/app_util.dart';

abstract class PincodeRepository {
  Future<ResponseModel> getPincodeInfoApi({required String pincode});
}

class PincodeRepositoryImp extends PincodeRepository {
  @override
  Future<ResponseModel> getPincodeInfoApi({required String pincode}) async {
    ResponseModel responseModel = ResponseModel(status: "",data: null,errors: null,message: "");
    try {
      responseModel = await HttpService().getRequest(
        fullUrl: ApisEndpoints.pincodeUrl + pincode,
      );
    } catch (e, t) {
      printLog(
          "getPincodeInfoApi  Exception==> ${e.toString()}>>${t.toString()}");
    }

    return responseModel;
  }
}
