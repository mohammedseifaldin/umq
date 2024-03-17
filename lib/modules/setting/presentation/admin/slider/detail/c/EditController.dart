import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/setting/presentation/admin/slider/detail/v/SliderDetailAdminPage.dart';

import 'package:umq/tools/values/ToolsValue.dart';

extension EditController on SlideDetailAdminState {

  Future setEditDataIfFound() async {
    //check no edit needed
    if( mEdit == null ) return;

    //update
    setState(() {
      _setPreviousPhoto();

    });
  }

  void _setPreviousPhoto(){
    if( mEdit == null ) return;

    photo_url_selected = mEdit!.image??"";
    if(photo_state != null )photo_state!.setImageBackgroundUrl( mEdit!.image??"" );
  }




}