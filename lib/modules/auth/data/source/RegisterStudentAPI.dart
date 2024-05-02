import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/auth/data/response/ResponseRegisterStudent.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/tools/network/ToolsAPI.dart';

typedef RegisterCallBack = Function(
    bool status, String msg, ResponseRegisterStudent response);

class RegisterStudentAPI {
  String mobile_country;
  String mobile_phone;
  String pass;
  String tokenMessage;

  late ResponseRegisterStudent response;
  RegisterCallBack callBack;

  RegisterStudentAPI(this.mobile_country, this.mobile_phone, this.pass,
      this.tokenMessage, this.callBack) {
    startAPI();
  }

  void startAPI() {
    String url = "${BackendConstant.baseUrlv1}/register";

    Map<String, dynamic> body = Map();
    // body[ "mobile_country"] = mobile_country;
    body["mobile"] = mobile_phone;
    body["country"] = mobile_country;
    body["password"] = pass;
    body["password_confirmation"] = pass;
    body["fid"] = tokenMessage;

    NetworkManagerDio().callBack(url, body: body,
        callback: (status, msg, json) {
      if (status) {
        parseJson(json);
      } else {
        callBack(false, msg, response);
      }
    });
  }

  void parseJson(Map<String, dynamic> mapJson) {
    //  Log.i( "RegisterStudentAPI - parseJson() - mapJson $mapJson "  );

    try {
      var response = ResponseRegisterStudent.fromJson(mapJson);
      //   Log.i( "RegisterStudentAPI - parseJson() - response $response "  );

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

      //check have user
      if (response.data == null) {
        callBack(false, response.message!, response);
        return;
      }

      //save object
      UserSingleTone.instance().saveUserLogin(response.data!, response.token!,
          () {
        //callback
        callBack(true, response.message!, response);
      });
    } catch (e) {
      Log.i("RegisterStudentAPI - excep: " + e.toString());
      callBack(false, e.toString(), response);
    }
  }
}
