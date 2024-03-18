import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/profile/presentation/admin/orginization/detail/c/ClickActionsUserDetails.dart';

import 'package:umq/modules/profile/presentation/admin/orginization/detail/v/OrgDetailAdminPage.dart';

extension ButtonsUserDetail on OrgDetailAdminState {
  Widget bt_save() {
    return ButtonTemplate.t("save", () async {
      await saveClick();
    }, margin: EdgeInsets.symmetric(vertical: DSDimen.space_level_1));
  }
}
