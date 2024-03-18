import 'package:umq/modules/place/presentation/admin/city/detail/v/CityDetailAdminPage.dart';
import 'package:umq/tools/values/ToolsValue.dart';

extension EditController on CityDetailAdminState {

  Future setEditDataIfFound() async {
    //check no edit needed
    if( mEdit == null ) return;

    //update
    setState(() {
      _setPreviousNameEn();
      _setPreviousNameAr();
    });
  }

  void _setPreviousNameEn(){
    if( mEdit == null ) return;

    nameEn_txt = mEdit!.name_en!;
    nameEn_controller.text = mEdit!.name_en!;
   // name_valid = AutovalidateMode.always;
  }

  String getEditNameEn(){
    if( mEdit == null ) return "";
    if( ToolsValue.isEmpty( mEdit!.name_en   ) ) return"";
    return mEdit!.name_en!;
  }


  void _setPreviousNameAr(){
    if( mEdit == null ) return;

    nameAr_txt = mEdit!.name_ar!;
    nameAr_controller.text = mEdit!.name_ar!;
   // email_valid = AutovalidateMode.always;
  }

  String getEditNameAr(){
    if( mEdit == null ) return "";
    if( ToolsValue.isEmpty( mEdit!.name_ar   ) ) return"";
    return mEdit!.name_ar!;
  }


}