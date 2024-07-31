import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school_club/src/data/models/response_model.dart';
import 'package:school_club/src/data/network/api_status_code.dart';
import 'package:school_club/src/data/network/http_service.dart';
import 'package:school_club/src/enums/role_enum.dart';
import 'package:school_club/src/ui/register/student_registration/student_data.dart';
import 'package:school_club/src/utility/app_data.dart';

abstract class RegisterRepository {
  Future<ResponseModel> registerApi(Map<String, dynamic> body);

  Future<ResponseModel> updateStudentApi(Map<String, dynamic> body);

  Future<ResponseModel> getDisablity(Map<String, dynamic> body);

  Future<ResponseModel> getCastListApi();

  Future<ResponseModel> getSerialNoApi();
}

class RegisterRepositoryImp extends RegisterRepository {
  @override
  Future<ResponseModel> registerApi(Map<String, dynamic> body) async {
    var responseModel =
        await ResponseModel(status: "", data: null, errors: null, message: "");

    var _fullUrl = ApisEndpoints.createStudentUrl;
    if (body["TYPE"] == RoleEnum.teacher.name) {
      _fullUrl = ApisEndpoints.createStaffUrl;
    }
    if (StudentData.selectedImage == null) {
      print("sdsdddddd") ;
      responseModel = await HttpService()
          .postRequest(fullUrl: _fullUrl, body: body, useTokenInBody: true);
    } else {
      print("sdsddddd>>>>>>>>>>>>>>>>>>d") ;

      responseModel = await HttpService().postRequestMultipart(
          fullUrl: _fullUrl,
          body: body,
          useTokenInBody: true,
          files: StudentData.selectedImage == null
              ? []
              : [StudentData.selectedImage!]);
    }
    return responseModel;
  }

  @override
  Future<ResponseModel> updateStudentApi(Map<String, dynamic> body) async {
    var responseModel =
        await ResponseModel(status: "", data: null, errors: null, message: "");

    var _fullUrl =
        "${ApisEndpoints.updateStudentUrl}${StudentData.selectedStudent?.id}";

    if (StudentData.selectedImage == null) {
      responseModel = await HttpService()
          .postRequest(fullUrl: _fullUrl, body: body, useTokenInBody: true);
    } else {
      responseModel = await HttpService().postRequestMultipart(
          fullUrl: _fullUrl,
          body: body,
          useTokenInBody: true,
          files: StudentData.selectedImage == null
              ? []
              : [StudentData.selectedImage!]);
    }
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
        fullUrl:
            "${ApisEndpoints.getSerialNoUrl}${AppData.userModel.data?.data.college.id ?? ""}",
        useTokenInBody: true);
    return res;
  }
}
