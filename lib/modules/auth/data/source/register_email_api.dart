import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/tools/network/BackendConstant.dart';

typedef RegisterCallBack = Future Function(
    bool status, String msg, Map<String, dynamic> response);

class RegisterEmailAPI {
  final String name;
  final String email;
  final String pass;
  final String mobile;
  final String country;
  final RegisterCallBack callBack;

  RegisterEmailAPI({
    required this.email,
    required this.pass,
    required this.callBack,
    required this.name,
    required this.mobile,
    required this.country,
  });
  Future call() async {
    const url = "${BackendConstant.baseUrlv3}/register";
    final body = {
      "email": email,
      "password": pass,
      "mobile": mobile,
      "name": name,
      "country": country,
    };
    return await NetworkManagerDio().callBack(
      url,
      body: body,
      callback: callBack,
    );
  }
}
