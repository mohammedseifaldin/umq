import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';

import '../../../../tools/cache/user_single_tone.dart';
import '../../../../tools/network/BackendConstant.dart';
import '../../../../tools/network/ToolsAPI.dart';
import '../response/response_register_student.dart';

typedef RegisterCallBack = Function(
    bool status, String msg, ResponseRegisterStudent response);

class RegisterStudentAPI {
  String mobileCountry;
  String phone;
  String pass;
  String tokenMessage;

  late ResponseRegisterStudent response;
  RegisterCallBack callBack;

  RegisterStudentAPI(this.mobileCountry, this.phone, this.pass,
      this.tokenMessage, this.callBack) {
    startAPI();
  }

  void startAPI() {
    String url = "${BackendConstant.baseUrlv1}/register";

    Map<String, dynamic> body = {};
    // body[ "mobile_country"] = mobile_country;
    body["mobile"] = phone;
    body["country"] = mobileCountry;
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
      Log.i("RegisterStudentAPI - excep: $e");
      callBack(false, e.toString(), response);
    }
  }
}
