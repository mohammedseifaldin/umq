import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:umq/modules/profile/presentation/admin/user/detail/v/UserDetailAdminPage.dart';
import 'package:umq/modules/place/data/model/MCityTools.dart';
import 'package:umq/tools/values/ToolsValue.dart';

extension EditUserController on UserDetailAdminState {
  Future setEditDataIfFound() async {
    //check no edit needed
    if (mEdit == null) return;

    //update
    setState(() {
      _setPreviousName();
      _setPreviousEmail();
      _setPreviousPhoto();
    });
  }

  void _setPreviousName() {
    if (mEdit == null) return;

    name_txt = mEdit!.name!;
    name_controller.text = mEdit!.name!;
    // name_valid = AutovalidateMode.always;
  }

  String getEditName() {
    if (mEdit == null) return "";
    if (ToolsValue.isEmpty(mEdit!.name)) return "";
    return mEdit!.name!;
  }

  void _setPreviousEmail() {
    if (mEdit == null) return;

    email_txt = mEdit!.email!;
    email_controller.text = mEdit!.email!;
    // email_valid = AutovalidateMode.always;
  }

  String getEditEmail() {
    if (mEdit == null) return "";
    if (ToolsValue.isEmpty(mEdit!.email)) return "";
    return mEdit!.email!;
  }

  void setPreviousCity() {
    if (mEdit == null) return;
    Log.i("_setPreviousCity() - length: " +
        UserDetailAdminState.city_list.length.toString());
    Log.i("_setPreviousCity() - mEdit: " + mEdit.toString());

    //check data downloaded or wait for wait for next setstate change
    if (UserDetailAdminState.city_list.isEmpty) return;

    //search
    var m =
        MCityTools.getModelById(UserDetailAdminState.city_list, mEdit!.cityId);

    //check not found
    if (ToolsValue.isZeroInt(m.id)) return;
    if (m.id == null) return;

    //now selected is
    city_selected_name = MCityTools.getNameByLang(context, m);
    city_selected_id = m.id!;
  }

  void _setPreviousPhoto() {
    if (mEdit == null) return;

    photo_url_selected = mEdit!.photo ?? "";
    if (photo_state != null)
      photo_state!.setImageBackgroundUrl(mEdit!.photo ?? "");
  }
}
