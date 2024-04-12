import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/network/ToolsAPI.dart';

import 'ResponseUploadFileLaravel.dart';

typedef UploadFileCallBack = Function(
    bool status, String msg, ResponseUploadFileLaravel response);

class UploadFileLaravelAPI {
  late UploadFileCallBack callBack;

  //data
  late String urlApiLink; //example  {{domain_v2}}/file-upload
  XFile? xFile;
  ResponseUploadFileLaravel response = ResponseUploadFileLaravel();
  Map<String, String>? bodyRequest;
  String? filePath;

  //------------------------------------------------------------------------- types

  @Deprecated(
      "this not working in Web Platform, use method (getDataByXFile) instead")
  Future getDataByFileUrl(
      {required String urlAPILink,
      required String filePath,
      Map<String, String>? body,
      required UploadFileCallBack callBack}) async {
    this.filePath = filePath;
    this.callBack = callBack;
    urlApiLink = urlAPILink;
    bodyRequest = body;

    await _startAPI();
  }

  Future getDataByXFile(
      {required String urlAPILink,
      required XFile xFile,
      Map<String, String>? body,
      required UploadFileCallBack callBack}) async {
    this.xFile = xFile;
    this.callBack = callBack;
    urlApiLink = urlAPILink;
    bodyRequest = body;

    await _startAPI();
  }

  //---------------------------------------------------------------------- type apis

  Future _startAPI() async {
    //set type requestFile
    NetworkRequestFile? requestFile;
    if (xFile != null) {
      requestFile = NetworkRequestFile.fromXFileAndBody(xFile!, bodyRequest);
    } else if (filePath != null) {
      requestFile =
          NetworkRequestFile.fromFilePathAndBody(filePath!, bodyRequest);
    }

    //header
    var token = UserSingleTone.instance().getToken();
    Map<String, String> header = NetworkHeaderTools.bearerToken(token);

    NetworkManagerDio().callBack(urlApiLink,
        type: NetworkTypeDio.file,
        requestFile: requestFile,
        headers: header, callback: (status, msg, json) {
      if (status) {
        parseJson(json);
      } else {
        callBack(false, "Upload failed, Try again", response);
      }
    });
  }

  //------------------------------------------------------------------- parse

  void parseJson(Map<String, dynamic> mapJson) {
    try {
      response = ResponseUploadFileLaravel.fromJson(mapJson);

      //check
      if (ToolsAPI.isFailed(response.code)) {
        callBack(false, "Failed to download", response);
        return;
      }

      //check have data
      if (response.data == null) {
        callBack(false, "Failed to download data", response);
        return;
      }

      //check have user
      if (response.data!.path == null) {
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
