import 'package:umq/modules/profile/presentation/admin/orginization/detail/v/OrgDetailAdminPage.dart';
import 'package:umq/tools/values/ToolsValue.dart';

extension EditController on OrgDetailAdminState {
  Future setEditDataIfFound() async {
    //check no edit needed
    if (mEdit == null) return;

    //update
    setState(() {
      _setPreviousNameEn();
    });
  }

  void _setPreviousNameEn() {
    if (mEdit == null) return;

    nameEnText = mEdit!.name;
    nameEnController.text = mEdit!.name;
    // name_valid = AutovalidateMode.always;
  }

  String getEditNameEn() {
    if (mEdit == null) return "";
    if (ToolsValue.isEmpty(mEdit!.name)) return "";
    return mEdit!.name;
  }
}
