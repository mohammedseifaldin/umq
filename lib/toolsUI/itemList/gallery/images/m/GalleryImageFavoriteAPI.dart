import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/teachers/data/response/ResponseGalleryUpdateFavorite.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/tools/network/ToolsAPI.dart';
import 'package:umq/toolsUI/itemList/gallery/images/c/ItemImageGalleryController.dart';
import 'package:umq/toolsUI/itemList/gallery/images/v/ItemImageGallery.dart';

extension GalleryImageFavoriteAPI on ItemImageGalleryState {
  /**
   * choose type "video" or "image" gallery
   */
  void apiFavGalleryAddToFavorite(int changeStatusTo) async {
    // Log.i( "favGallery() - galleryId: " + galleryId.toString() );

    //url
    String url = BackendConstant.baseUrlv1 + '/fav_gallery_image';
    int myUserId = await UserSingleTone.instance().getUserId();

    //header
    var token = await UserSingleTone.instance().getToken();
    Map<String, String> header = NetworkHeaderTools.bearerToken(token);

    //body
    Map<String, dynamic> body = {};
    body["user_id"] = myUserId;
    body["gallery_id"] = imageGallery.id!.toString();
    body["favorite"] = changeStatusTo.toString();

    NetworkManagerDio().callBack(url, body: body, headers: header,
        callback: (status, msg, json) {
      ResponseGalleryUpdateFavorite response =
          ResponseGalleryUpdateFavorite().fromJson(json);

      // Log.i( "favGalleryAddToFavorite - NetworkManagerDio - response: " + response.toString() );
      // Log.i( "favGalleryAddToFavorite - NetworkManagerDio - response.code: " + response.code.toString() );

      //failed
      if (ToolsAPI.isFailed(response.code)) {
        failedToChangeStatus(changeStatusTo);
        return;
      }
    });
  }
}
