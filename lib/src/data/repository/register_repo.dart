import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school_club/src/data/models/response_model.dart';
import 'package:school_club/src/data/network/api_status_code.dart';
import 'package:school_club/src/data/network/http_service.dart';

abstract class RegisterRepository {
  Future<ResponseModel> registerApi(Map<String, dynamic> body);

  Future<ResponseModel> getCastListApi();
}

class RegisterRepositoryImp extends RegisterRepository {
  @override
  Future<ResponseModel> registerApi(Map<String, dynamic> body) async {
    var responseModel =
        await ResponseModel(status: "", data: null, errors: null, message: "");
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(body["role_type"])
        .where("email", isEqualTo: body["email"])
        .get();
    if (querySnapshot.docs.isEmpty) {
      var res = await FirebaseFirestore.instance
          .collection(body["role_type"])
          .add(body);
      responseModel.status = "${RepoResponseStatus.success}";
      responseModel.message =
          "Registration Successful! Your records have been successfully registered";
      responseModel.data = res;
    } else {
      responseModel.status = "${RepoResponseStatus.error}";
      responseModel.message =
          "Email Already Exists! Please use a different email address.";
      responseModel.data = {};
    }
    return responseModel;
  }

  @override
  Future<ResponseModel> getCastListApi() async {
    var responseModel =
        await ResponseModel(status: "", data: null, errors: null, message: "");
    responseModel = await HttpService()
        .getRequest(fullUrl: ApisEndpoints.getCasteUrl,useTokenInBody: true);
    return responseModel;
  }
}
