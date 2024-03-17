
import 'package:umq/toolsUI/dialog/CheckoutLoginDialog.dart';
import 'package:umq/toolsUI/itemList/gallery/images/v/ItemImageGallery.dart';
import 'package:umq/toolsUI/itemList/gallery/images/m/GalleryImageFavoriteAPI.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/network/ToolsAPI.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

extension ItemImageGalleryController on ItemImageGalleryState {



  //------------------------------------------------------------------- api


  Future  changeStatusOfGalleryFavorite(  ) async {


    //check login
    if( await UserSingleTone.instance().isGuest() ) {
      CheckoutLoginDialog.show(contextPage);
      return false ;
    }

    //change to
    var changeStatusTo = ToolsAPI.changeStatus( imageGallery.favorite!);
    setState(() {
      imageGallery.favorite = changeStatusTo;
    });


    apiFavGalleryAddToFavorite(  changeStatusTo );
  }

  void failedToChangeStatus(int changeStatusTo) {
    ToolsToast.i(context,  "Failed to add to Favorite" );

    //
    setState(() {
      var original = ToolsAPI.changeStatus( imageGallery.favorite!);
      imageGallery.favorite = original;
    });
  }
}