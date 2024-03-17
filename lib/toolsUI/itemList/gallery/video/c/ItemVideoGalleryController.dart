
import 'package:umq/toolsUI/dialog/CheckoutLoginDialog.dart';
import 'package:umq/toolsUI/itemList/gallery/video/m/GalleryVideoFavoriteAPI.dart';
import 'package:umq/toolsUI/itemList/gallery/video/v/ItemVideoGallery.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/network/ToolsAPI.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

extension ItemVideoGalleryController  on ItemVideoGalleryState {


  Future  changeStatusOfGalleryFavorite(  ) async {


    //check login
    if( await UserSingleTone.instance().isGuest() ) {
      CheckoutLoginDialog.show( widget.pageContext );
      return false ;
    }

    //change to
    var changeStatusTo = ToolsAPI.changeStatus( m.favorite!);
    setState(() {
      m.favorite = changeStatusTo;
    });


    apiFavoriteGalleryVideo(  changeStatusTo );
  }


  void failedToChangeStatus(int changeStatusTo) {
    ToolsToast.i(context,  "Failed to add to Favorite" );

    //
    setState(() {
      var original = ToolsAPI.changeStatus( m.favorite!);
      m.favorite = original;
    });
  }


}