import 'dart:async';

import 'package:umq/tools/cache/user_single_tone.dart';

Future<String> getToken() async {
  return UserSingleTone.instance().getToken();
}

Future<String> getUserID() async {
  int uid = UserSingleTone.instance().getUserId();
  String result = "$uid";
  return result;
}

logout() async {
  await UserSingleTone.instance().setLogout();
}

bool isLogin() {
  return UserSingleTone.instance().isLogin();
}
