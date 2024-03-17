import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/modules/teachers/data/response/ResponseGalleryUpdateFavorite.dart';
import 'package:umq/toolsUI/itemList/gallery/video/c/ItemVideoGalleryController.dart';
import 'package:umq/toolsUI/itemList/gallery/video/v/ItemVideoGallery.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/tools/network/ToolsAPI.dart';

extension GalleryVideoFavoriteAPI on ItemVideoGalleryState {
  //---------------------------------------------------- api

  Future apiFavoriteGalleryVideo(int changeStatusTo) async {
    String url = BackendConstant.baseUrlv1 + '/fav_gallery_video';

    int myUserId = await UserSingleTone.instance().getUserId();

    //header
    var token = await UserSingleTone.instance().getToken();
    Map<String, String> header = NetworkHeaderTools.bearerToken(token);

    //body
    Map<String, dynamic> body = Map();
    body["user_id"] = myUserId;
    body["gallery_id"] = m.id;
    body["favorite"] = changeStatusTo.toString();

    new NetworkManagerDio().callBack(url, body: body, headers: header,
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
