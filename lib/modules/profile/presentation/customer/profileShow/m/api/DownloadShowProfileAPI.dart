import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/profile/presentation/customer/profileShow/m/ResponseSingleUser.dart';
import 'package:umq/modules/profile/presentation/customer/profileShow/v/profile_view.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/network/BackendConstant.dart';

extension DownloadShowProfileAPI on ProfileScreenState {
  downloadProfileData() async {
    //data
    int userId = UserSingleTone.instance().getUserId();
    String url = "${BackendConstant.domain}/public/api/v1/auth/users/$userId";

    //header
    var token = UserSingleTone.instance().getToken();
    Map<String, String> header = NetworkHeaderTools.bearerToken(token);

    NetworkManagerDio().callBack(url, type: NetworkTypeDio.get, headers: header,
        callback: (status, msg, json) {
      // Log.i( "downloadProfileData() - json " + json.toString() );
      setState(() {
        responseUser = ResponseSingleUser.fromJson(json);
      });
    });
  }
}
