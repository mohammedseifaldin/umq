import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:umq/modules/profile/presentation/admin/user/detail/c/ClickActionsUserDetails.dart';
import 'package:umq/modules/profile/presentation/admin/user/detail/v/UserDetailAdminPage.dart';

extension ButtonsUserDetail on UserDetailAdminState {
  Widget bt_save() {
    return ButtonTemplate.t("save", () async {
      await saveClick();
    }, margin: EdgeInsets.symmetric(vertical: DSDimen.space_level_1));
  }
}
