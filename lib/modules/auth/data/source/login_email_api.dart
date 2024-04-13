import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/tools/network/BackendConstant.dart';

typedef LoginCallBack = void Function(
    bool status, String msg, Map<String, dynamic> response);

class LoginEmailAPI {
  final String email;
  final String pass;
  final LoginCallBack callBack;

  LoginEmailAPI({
    required this.email,
    required this.pass,
    required this.callBack,
  });
  Future call() async {
    const url = "${BackendConstant.baseUrlv3}/login";
    final body = {
      "email": email,
      "password": pass,
    };
    return await NetworkManagerDio().callBack(
      url,
      body: body,
      callback: callBack,
    );
  }
}
