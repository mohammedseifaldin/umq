import 'package:flutter/material.dart';
import 'package:umq/modules/auth/data/response/become_provider_response.dart';
import 'package:umq/modules/auth/provider/auth_change_notifier.dart';
import 'package:umq/modules/place/data/response/city_response.dart';
import 'package:umq/modules/profile/data/response/organization_response.dart';
import 'package:umq/tools/Dios/fresh_dio.dart' as dio;
import 'package:umq/tools/cache/session_repo.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/fcm/abdo/general/FCMSubscribe.dart';
import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/toolsUI/dialog/snack_bar_message.dart';
import 'package:umq/toolsUI/progress/lock_overlay/lock_overlay.dart';

extension BecomeTeacherNotifier on AuthChangeNotifier {
  void registerProvider() async {
    //_updateProgressBecomeTeacher(true);
    FocusScope.of(becomeTeacherScaffoldKey.currentContext!).unfocus();
    if (becomeTeacherSelectedCity!.id == null) {
      SnackBarHelper.ShowErrorMessage(
          becomeTeacherScaffoldKey.currentContext, "Select City");
      return;
    }
    if (becomeTeacherSelectedOrganization!.id == null) {
      SnackBarHelper.ShowErrorMessage(
          becomeTeacherScaffoldKey.currentContext, "Select Organization");
      return;
    }
    LockOverlay()
        .showClassicLoadingOverlay(becomeTeacherScaffoldKey.currentContext);
    becomeProvdierRequest().then((value) {
      LockOverlay().closeOverlay();
      if (value.status) {
        successBecomeProvider(value);

        // Navigator.pushNamedAndRemoveUntil(scaffoldKey.currentContext!, '/homeTest', (route) => false);
      } else {
        var sMessage = ScaffoldMessenger.of(
            becomeTeacherScaffoldKey.currentState!.context);

        sMessage.showSnackBar(SnackBar(
          content: Text(value.message),
        ));
      }
    }).catchError((e) {
      LockOverlay().closeOverlay();
    }).whenComplete(() {
      LockOverlay().closeOverlay();
    });
  }

  void getCity() {
    cityRequest().then((value) {
      becomeTeacherCities.addAll(value.data);
      becomeTeacherSelectedCity = becomeTeacherCities.first;
      notifyListeners();
    });
  }

  void getOrgnaization() {
    organizationRequest().then((value) {
      becomeTeacherOrganization.addAll(value.data);
      becomeTeacherSelectedOrganization = becomeTeacherOrganization.first;
      notifyListeners();
    });
  }

  Future<BecomeProviderResponse> becomeProvdierRequest() async {
    String UserID = await getUserID();
    print(UserID);
    var response = await dio.httpClient().post("v1/auth/provider", data: {
      "user_id": UserID,
      "whats": "010",
      "city_id": "${becomeTeacherSelectedCity!.id}",
      "org_id": "${becomeTeacherSelectedOrganization!.id}",
    });
    return BecomeProviderResponse.fromJson(response.data);
  }

  Future<CityListResponse> cityRequest() async {
    var response = await dio.httpClientWithHeader(await getToken()).get(
        "v1/auth/city",
        queryParameters: {'page': "1", "paginator": "100"});
    return CityListResponse.fromJson(response.data);
  }

  Future<OrganizationResponse> organizationRequest() async {
    var response = await dio.httpClientWithHeader(await getToken()).get(
        "v1/auth/organization",
        queryParameters: {'page': "1", "paginator": "100"});
    return OrganizationResponse.fromJson(response.data);
  }

  //-----------------------------------------------

  Future successBecomeProvider(BecomeProviderResponse response) async {
    //fcm remove old
    if (UserSingleTone.instance().isLogin()) {
      await FCMSubscribe.userRemoveRole();
    }

    //provider
    await UserSingleTone.instance().setRoleType("provider");

    //fcm
    if (UserSingleTone.instance().isLogin()) {
      await FCMSubscribe.userUpdateRole();
    }

    //next page
    GoTo.chooseHomeByTypeRoleUser(becomeTeacherScaffoldKey.currentContext!);
  }
}
