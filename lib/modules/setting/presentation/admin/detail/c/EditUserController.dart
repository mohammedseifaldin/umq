import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/setting/presentation/admin/detail/v/SettingDetailAdminPage.dart';

extension EditUserController on SettingDetailAdminState {

  Future setEditDataIfFound() async {
    //check no edit needed
    if( mEdit == null ) return;

    //update
    setState(() {

      _setPreviousAboutUs();
      _setPreviousTerms();
    });
  }


  void _setPreviousAboutUs() {
    if( mEdit == null ) return;
    if( ToolsValidation.isEmpty(mEdit!.aboutUs) ) return;

    aboutUsUrl =  mEdit!.aboutUs??"";
  }

  void _setPreviousTerms() {
    if( mEdit == null ) return;
    if( ToolsValidation.isEmpty(mEdit!.terms) ) return;

    termsUrl =  mEdit!.terms??"";
  }


}