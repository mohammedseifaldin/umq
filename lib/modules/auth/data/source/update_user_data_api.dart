import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';

import '../../../../tools/cache/user_single_tone.dart';
import '../../../../tools/network/BackendConstant.dart';
import '../../../../tools/network/ToolsAPI.dart';
import '../response/response_register_student.dart';
import 'register_student_api.dart';

class UpdateUserDataAPI {
  String userId;
  String name;
  String email;
  String? photo = "";

  late ResponseRegisterStudent response;
  RegisterCallBack callBack;

  UpdateUserDataAPI(
      this.userId, this.name, this.email, this.photo, this.callBack) {
    startAPI();
  }

  Future startAPI() async {
    String url = "${BackendConstant.baseUrlv2}/user/updateData";

    //header
    var token = UserSingleTone.instance().getToken();
    Map<String, String> header = NetworkHeaderTools.bearerToken(token);

    //body
    Map<String, dynamic> body = {};
    body["name"] = name; //name
    body["email"] = email;
    body["photo"] = photo;

    NetworkManagerDio().callBack(url, body: body, headers: header,
        callback: (status, msg, json) {
      if (status) {
        parseJson(json);
      } else {
        callBack(false, msg, response);
      }
    });
  }

  /**
   *
      Future startAPI() async  {

      String url = BackendConstant.baseUrl_v1 + "/users/" + userId;

      //header
      var token = await UserSingleTone.instance().getToken();
      Map<String, String> header = NetworkHeaderTools.bearerToken( token );

      //body
      Map<String, dynamic > body = Map();
      body[ "name"] = name; //name
      body[ "email"] = email;
      body[ "photo"] = photo;

      NetworkManagerDio().callBack(url, body: body, headers: header, type: NetworkTypeDio.put, callback: (status, msg, json){

      if( status ) {
      parseJson(json );
      } else  {
      callBack( false , msg , response);
      }

      });
      }

   */

  Future parseJson(Map<String, dynamic> mapJson) async {
    try {
      var response = ResponseRegisterStudent.fromJson(mapJson);
      //Log.i( "login - parseJson() - response $response "  );

      //check failed
      if (ToolsAPI.isFailed(response.code)) {
        callBack(false, response.message!, response);
        return;
      }

      //check have data
      if (response.data == null) {
        callBack(false, response.message!, response);
        return;
      }

      //get token current
      String tokenCurrent = UserSingleTone.instance().getToken();

      //save object
      UserSingleTone.instance().saveUserLogin(response.data!, tokenCurrent, () {
        //callback
        callBack(true, response.message ?? "success", response);
      });
    } catch (e) {
      Log.i("UpdateUserDataAPI - excep: $e");
      callBack(false, e.toString(), response);
    }
  }
}
