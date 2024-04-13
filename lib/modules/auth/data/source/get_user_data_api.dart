import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';

import '../../../../tools/network/BackendConstant.dart';

typedef GetDataCallBack = void Function(
    bool status, String msg, Map<String, dynamic> response);

class GetUserDataAPI {
  final String token;
  final GetDataCallBack callBack;
  GetUserDataAPI({
    required this.token,
    required this.callBack,
  });
  Future call() async {
    const url = "${BackendConstant.baseUrlv3}/me";
    final body = {"token": token};
    return await NetworkManagerDio().callBack(
      url,
      body: body,
      callback: callBack,
    );
  }
}
