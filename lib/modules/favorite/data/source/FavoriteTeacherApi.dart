
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';

import 'package:umq/modules/teachers/data/response/ResponseGalleryUpdateFavorite.dart';

import 'package:umq/tools/cache/user_single_tone.dart';

import 'package:http/http.dart' as http;
import 'package:umq/toolsUI/app_constants.dart';


class FavoriteTeacherApi {




  Future favProvider(providerId) async {
    var sendUrl = Uri.parse('${ApiConstants.endPoint_v1}/fav_provider');
    String userToken = await UserSingleTone.instance().getToken();
    int myUserId = await UserSingleTone.instance().getUserId();

    try {
      var response = await http.post(sendUrl, headers: {
        'Authorization': 'Bearer $userToken',
        "Accept": "application/json",
      }, body: {
        "user_id": myUserId.toString(),
        "provider_id": providerId,
        "favorite": '1'
      }).then((response) async {
        print(response.body.toString());

        return response;
      });
      return response.statusCode;
    } catch (e) {
      print(e);
    }
  }

  /**
   * choose type "video" or "image" gallery
   */
  Future<ResponseGalleryUpdateFavorite> favGalleryAddToFavorite(galleryId, String type) async {
    Log.i( "favGallery() - galleryId: " + galleryId.toString() );

    String url = type == 'video'
        ? '${ApiConstants.endPoint_v1}/fav_gallery_video'
        : '${ApiConstants.endPoint_v1}/fav_gallery_image';



    int myUserId = await UserSingleTone.instance().getUserId();

    //header
    var token = await UserSingleTone.instance().getToken();
    Map<String, String> header = NetworkHeaderTools.bearerToken( token );

    //body
    Map<String,dynamic> body = Map();
    body["user_id"] = myUserId;
    body["gallery_id"] = galleryId;
    body["favorite"] = "1";


    var response = await new NetworkManagerDio().get(url, body: body , headers: header );
    ResponseGalleryUpdateFavorite model = ResponseGalleryUpdateFavorite().fromJson( response.data);
    return model;
  }






}
