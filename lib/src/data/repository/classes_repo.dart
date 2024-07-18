import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school_club/src/data/models/response_model.dart';
import 'package:school_club/src/data/network/api_status_code.dart';
import 'package:school_club/src/data/network/http_service.dart';
import 'package:school_club/src/utility/app_util.dart';
import 'package:school_club/src/utility/firestore_table.dart';

abstract class ClassesRepository {
  Future<ResponseModel> getClassesApi(Map<String, dynamic> map);

  Future<ResponseModel> createClassApi(Map<String, dynamic> map);
}

class ClassesRepositoryImp extends ClassesRepository {
  @override
  Future<ResponseModel> getClassesApi(Map<String, dynamic> map) async {
    var res = await HttpService().postRequest(
        fullUrl: ApisEndpoints.getClassUrl, useTokenInBody: true, body: map);
    return res;
  }

  @override
  Future<ResponseModel> createClassApi(Map<String, dynamic> map) async {
    var responseModel =
        await ResponseModel(status: "", data: null, errors: null, message: "");
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(tblClass)
        .where("school_code", isEqualTo: map["school_code"])
        .where("class_name", isEqualTo: map["class_name"])
        .get();
    if (querySnapshot.docs.isEmpty) {
      var res = await FirebaseFirestore.instance.collection(tblClass).add(map);
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(tblClass)
          .where("school_code", isEqualTo: map["school_code"])
          .get();
      responseModel.status = "${RepoResponseStatus.success}";
      responseModel.message = "Class Created Successful!";
      responseModel.data = querySnapshot.docs;
    } else {
      responseModel.status = "${RepoResponseStatus.error}";
      responseModel.message =
          "Class name already exists! Please use a different name.";
      responseModel.data = {};
    }

    return responseModel;
  }
}
