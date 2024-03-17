import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';

class ResponseGalleryUpdateFavorite {


  String? status;
  int? code;
 // DataFavoriteGallery? data;


  ResponseGalleryUpdateFavorite fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    Log.i( "fromJson - code: " + code.toString() );
   // data = json['data'] != null ? new DataFavoriteGallery().fromJson(json['data']) : null;
    return this;
  }

  @override
  String toString() {
    return 'ResponseGalleryUpdateFavorite{status: $status, code: $code }';
  }
}

// class DataFavoriteGallery {
//
//   int? id;
//   int? userId;
//   int? galleryId;
//   int? favorite;
//
//   @override
//   String toString() {
//     return 'DataFavoriteGallery{id: $id, userId: $userId, galleryId: $galleryId, favorite: $favorite}';
//   }
//
//   DataFavoriteGallery fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     galleryId = json['gallery_id'];
//     favorite = json['favorite'];
//     Log.i( "fromJson - favorite: " + favorite.toString() );
//     return this;
//   }
//
//
//
// }
