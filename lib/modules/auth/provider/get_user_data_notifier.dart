import 'package:flutter/material.dart';
import 'package:umq/modules/auth/data/source/get_user_data_api.dart';
import 'package:umq/modules/auth/provider/AuthChangeNotifier.dart';
import 'package:umq/modules/profile/data/model/m_user.dart';
import 'package:umq/tools/cache/user_single_tone.dart';

extension RegisterNotifier on AuthChangeNotifier {
  Future startGettingUserData({
    required BuildContext context,
    required String token,
  }) async {
    await GetUserDataAPI(
      token: token,
      callBack: (status, msg, response) async {
        if (status) {
          UserSingleTone.instance().saveUserLogin(
            MUser.fromJson(response),
            token,
            () => null,
          );
        }
      },
    ).call();
  }
}
