import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/tools/data/general/GeneralCallBack.dart';
import 'package:umq/tools/data/general/ResponseGeneral.dart';
import 'package:umq/modules/notification/data/response/ResponseNotificationAdminSingle.dart';
import 'package:umq/modules/profile/data/model/m_user.dart';
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/tools/network/ToolsAPI.dart';

typedef NotificationCreateAPICallBack = Function(
    bool status, String msg, ResponseNotificationAdminSingle response);

class NotificationCreateAPI {
  String topic = "";
  String title = "";
  String message = "";

  ResponseNotificationAdminSingle response =
      new ResponseNotificationAdminSingle();
  late NotificationCreateAPICallBack callBack;

  //------------------------------------------------------------------------- types

  Future toSpecificUser(MUser mUser, String title, String message,
      NotificationCreateAPICallBack callBack) async {
    this.callBack = callBack;
    this.title = title;
    this.message = message;

    this.topic = generateTopicByUserId(mUser);

    await _startAPI();
  }

  Future toAllUser(String topic, String title, String message,
      NotificationCreateAPICallBack callBack) async {
    this.callBack = callBack;
    this.topic = topic;
    this.title = title;
    this.message = message;

    await _startAPI();
  }

  //---------------------------------------------------------------------------- api

  /**
   exmaple:
      "topic": "id_16",
   */
  String generateTopicByUserId(MUser mUser) {
    return "id_" + mUser.id.toString();
  }

  Future _startAPI() async {
    //{{DEVServerURL}}/notification_admin
    String url = BackendConstant.baseUrlv1 + "/notification_admin";

    //header
    var token = await UserSingleTone.instance().getToken();
    Map<String, String> header = NetworkHeaderTools.bearerToken(token);
    /**
        {
        "topic": "id_16",
        "title": "Test Num 3",
        "message": "Welcome id 16"
        }
     */
    //body
    Map<String, dynamic> body = Map();
    body["topic"] = topic;
    body["title"] = title;
    body["message"] = message;

    NetworkManagerDio().callBack(url,
        type: NetworkTypeDio.post,
        headers: header,
        body: body, callback: (status, msg, json) {
      //Log.i("loginAPI - status: " + status.toString() );

      if (status) {
        parseJson(json);
      } else {
        callBack(false, msg, response);
      }
    });
  }

  //------------------------------------------------------------------- parse

  void parseJson(Map<String, dynamic> mapJson) {
    try {
      response = ResponseNotificationAdminSingle.fromJson(mapJson);
      //Log.i( "login - parseJson() - response $response "  );

      //check
      if (ToolsAPI.isFailed(response.code)) {
        callBack(false, "Check Internet Connection", response);
        return;
      }

      //check status FCM Faield
      if (ToolsAPI.isFailed(response.data!.fcmStatus)) {
        callBack(false, "Try again send notification", response);
        return;
      }

      //callback
      callBack(true, "Success", response);
    } catch (e) {
      Log.i("action api - excep: " + e.toString());
      callBack(false, e.toString(), response);
    }
  }
}
