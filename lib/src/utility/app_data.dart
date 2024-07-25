import 'package:school_club/src/data/models/cast_model.dart';

import '../data/models/user_model.dart';

class AppData {
  static Map<String ,dynamic> studentMap ={} ;
  static String authToken = "";
  static List<Caste> subCastList = [];
  static UserModel userModel = UserModel(status: '',errors: "",message: "",data: null) ;
}
