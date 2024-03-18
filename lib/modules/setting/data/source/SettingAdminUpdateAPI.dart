import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/setting/data/model/MSettingAdmin.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/data/general/GeneralCallBack.dart';
import 'package:umq/tools/data/general/ResponseGeneral.dart';
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/tools/network/ToolsAPI.dart';

class SettingAdminUpdateAPI {
  MSettingAdmin? mSettingAdmin;

  late GeneralCallBack callBack;

  Future setData(MSettingAdmin mSettingAdmin, GeneralCallBack callBack) async {
    this.callBack = callBack;
    this.mSettingAdmin = mSettingAdmin;

    await _startAPI();
  }

  Future _startAPI() async {
    String url =
        BackendConstant.baseUrlv2 + "/setting_admin/updateAboutUsAndTerms";

    //header
    var token = await UserSingleTone.instance().getToken();
    Map<String, String> header = NetworkHeaderTools.bearerToken(token);

    //body
    Map<String, dynamic> body = Map();

    if (ToolsValidation.isValid(mSettingAdmin!.aboutUs)) {
      body["about_us"] = mSettingAdmin!.aboutUs;
    }
    if (ToolsValidation.isValid(mSettingAdmin!.terms)) {
      body["terms"] = mSettingAdmin!.terms;
    }

    NetworkManagerDio().callBack(url, headers: header, body: body,
        callback: (status, msg, json) {
      //Log.i("ConferenceCreateAPI - status: " + status.toString() );

      if (status) {
        parseJson(json);
      } else {
        callBack(0, msg);
      }
    });
  }

  //------------------------------------------------------------------- parse

  void parseJson(Map<String, dynamic> mapJson) {
    try {
      var response = ResponseGeneral().fromJson(mapJson);
      //Log.i( "ConferenceCreateAPI - parseJson() - response $response "  );

      //check
      if (ToolsAPI.isFailed(response.code)) {
        callBack(0, "Failed to download");
        return;
      }

      //callback
      callBack(1, "Success");
    } catch (e) {
      Log.i("action api - excep: " + e.toString());
      callBack(0, e.toString());
    }
  }
}
