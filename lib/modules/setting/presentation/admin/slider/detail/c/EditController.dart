import 'package:umq/modules/setting/presentation/admin/slider/detail/v/SliderDetailAdminPage.dart';

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