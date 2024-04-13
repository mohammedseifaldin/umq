import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';

import '../../../../tools/cache/user_single_tone.dart';
import '../../../../tools/network/BackendConstant.dart';
import '../../../../tools/network/ToolsAPI.dart';
import '../response/response_login_admin.dart';

typedef LoginCallBack = Function(
    bool status, String msg, ResponseLoginAdmin response);

class LoginPhoneAPI {
  String mobileCountry;
  String mobilePhone;
  // String email;
  String pass;

  ResponseLoginAdmin response = ResponseLoginAdmin();
  LoginCallBack callBack;

  LoginPhoneAPI(
      this.mobileCountry, this.mobilePhone, this.pass, this.callBack) {
    startAPI();
  }

  void startAPI() {
    String url = "${BackendConstant.baseUrlv1}/login";

    //String fullPhone = PhoneEgyption.getFullPhone( mobile_country, mobile_phone );
    String fullPhone =
        ToolsPhone.fixEgyptAndSaudiNumber(mobileCountry, mobilePhone);
    Map<String, dynamic> body = {};

    body["username"] = fullPhone;
    body["password"] = pass;

    NetworkManagerDio().callBack(url, body: body,
        callback: (status, msg, json) {
      if (status) {
        parseJson(json);
      } else {
        callBack(false, "Download Failed", response);
      }
    });
  }

  void parseJson(Map<String, dynamic> mapJson) {
    try {
      var response = ResponseLoginAdmin().fromJson(mapJson);
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

      //check have user
      if (response.data!.user == null) {
        callBack(false, response.message!, response);
        return;
      }

      //save object
      UserSingleTone.instance()
          .saveUserLogin(response.data!.user!, response.data!.accessToken!, () {
        //callback
        callBack(true, response.message!, response);
      });
    } catch (e) {
      Log.i("loginAPI - excep: $e");
      callBack(false, e.toString(), response);
    }
  }
}
