import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import '../../c/ClickActionsUserDetails.dart';
import '../../c/EditController.dart';
import '../OrgDetailAdminPage.dart';
import '../../../../../../../../tools/resourceProject/ResourceDimenAdmin.dart';

extension ContentUserDetail on OrgDetailAdminState {
  //---------------------------------------------------------------------- name

  Widget name_en() {
    var row = RowTemplate.scroll(contextPage!, [tv_nameEn(), tf_nameEn()]);

    return Container(
      margin: EdgeInsets.only(
          top: DSDimen.space_level_2, left: DSDimen.space_level_2),
      child: row,
    );
  }

  Widget tv_nameEn() {
    return TextTemplate.t("name",
        width: AdminDSDimen.inputFiled_title_width, levelDS: LevelDS.l2);
  }

  Widget tf_nameEn() {
    return TextFieldFastor(
        width: AdminDSDimen.inputFiled_value_width,
        hint_text: getEditNameEn(),
        autovalidateMode: nameEnValid,
        validatorCustom: ValidatorTemplate.name(),
        keyboardType: TextInputType.name,
        decoration: BoarderHelper.box(),
        padding: EdgeInsets.all(DSDimen.textfield_auto_padding),
        onChanged: (value) => nameEnText = value);
  }

  //------------------------------------------------------------ save

  Widget save() {
    var bt = ButtonTemplate.t("save", () {
      saveClick();
    },
        margin: EdgeInsets.only(
            top: DSDimen.space_level_2 + 2, bottom: DSDimen.space_level_1));

    return Container(
      alignment: Alignment.center,
      child: bt,
    );
  }
}
