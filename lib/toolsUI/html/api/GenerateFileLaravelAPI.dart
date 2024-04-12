import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/network/ToolsAPI.dart';

import 'ResponseGenerateFile.dart';

typedef GenerateFileCallBack = Function(
    bool status, String msg, ResponseGenerateFile response);

class GenerateFileLaravelAPI {
  late GenerateFileCallBack callBack;

  //data
  late String urlApiLink; //example  {{domain_v2}}/file-upload
  late String
      content; //example: /data/user/0/com.universityksa.university/cache/image_picker2894120432280038995.jpg
  late String file_name;

  ResponseGenerateFile response = ResponseGenerateFile();

  Future getDataByPostContent(
      {required String urlAPILink,
      required String content,
      required String file_name,
      required GenerateFileCallBack callBack}) async {
    this.content = content;
    this.callBack = callBack;
    urlApiLink = urlAPILink;
    this.file_name = file_name;

    await _startAPI();
  }

  //---------------------------------------------------------------------- type apis

  Future _startAPI() async {
    //header
    var token = UserSingleTone.instance().getToken();
    Map<String, String> header = NetworkHeaderTools.bearerToken(token);

    //body
    Map<String, String> body = {};
    body["type"] = "html";
    body["data"] = content;
    body["file_name_unique"] = file_name;

    //network
    NetworkManagerDio().callBack(urlApiLink,
        type: NetworkTypeDio.post,
        body: body,
        headers: header, callback: (status, msg, json) {
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
      response = ResponseGenerateFile.fromJson(mapJson);

      //check
      if (ToolsAPI.isFailed(response.code)) {
        callBack(
            false, response.message ?? "Failed To Generate File ", response);
        return;
      }

      //check have user
      if (response.fullPath == null) {
        callBack(false, "No path Found", response);
        return;
      }

      //callback
      callBack(true, "Success", response);
    } catch (e) {
      Log.i("exe: $e");
      callBack(false, e.toString(), response);
    }
  }
}
