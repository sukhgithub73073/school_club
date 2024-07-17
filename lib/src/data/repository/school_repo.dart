
import 'package:school_club/src/data/models/response_model.dart';

abstract class SchoolRepository {
  Future<ResponseModel> getSchoolDetail({required Map<String ,dynamic> map});
}
class SchoolRepositoryImp extends SchoolRepository{
  @override
  Future<ResponseModel> getSchoolDetail({required Map<String, dynamic> map}) async {
    ResponseModel model = await ResponseModel(status: "",data: null,errors: null,message: "");
    Future.delayed(Duration(seconds: 5)) ;
    return model;
  }
}

