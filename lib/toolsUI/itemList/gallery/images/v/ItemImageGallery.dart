
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/teachers/data/model/MImageGallery.dart';
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/modules/teachers/data/response/ResponseGalleryUpdateFavorite.dart';
import 'package:umq/modules/teachers/data/response/ResponseSingleTeacher.dart';

import 'package:umq/modules/favorite/data/source/FavoriteTeacherApi.dart';
import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/tools/translation/ProjectTranslation.dart';
import 'package:umq/toolsUI/dialog/CheckoutLoginDialog.dart';
import 'package:umq/toolsUI/itemList/gallery/images/c/ItemImageGalleryController.dart';
import 'package:umq/toolsUI/snack_bar.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';
import 'package:umq/tools/resourceProject/DrawableProject.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/tools/network/ToolsAPI.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

class ItemImageGallery extends StatefulWidget {

  BuildContext contextPage;
  MImageGallery  imageGallery;

  ItemImageGallery(this.contextPage, this.imageGallery);

  @override
  ItemImageGalleryState createState() {
   return ItemImageGalleryState(this.contextPage, this.imageGallery);
  }
}


class ItemImageGalleryState extends State<ItemImageGallery > {

  BuildContext contextPage;
  MImageGallery  imageGallery;

  ItemImageGalleryState(this.contextPage, this.imageGallery);

  @override
  Widget build(BuildContext context) {
    return itemImageSlider();
  }


  //----------------------------------------------------------------------- item list

  Widget itemImageSlider( ){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
      child: InkWell(
          onTap: () {

            String imageUrl = imageGallery.file!;
            GoTo.fullScreenImage(contextPage, imageUrl);

          },
          child: stackImage()),
    );
  }

  Widget stackImage() {
    return Stack(
      children: [


        im_photo(),

        //favorite
        Positioned(
          left: 10,
          top: 10,
          child: favorite_bt_gallery( ),
        ),
      ],
    );
  }

  //----------------------------------------------------------------------------- image photo

  Widget im_photo(){
    return ImageView(width: 200, height: 135 ,
      assetAspectRatio: DrawableProject.placeholderImage,
      urlBackground: imageGallery.file!,
      radius_all: 15,
      onPressed: (){
        GoTo.fullScreenImage(context,  imageGallery.file!);
      },
    );
  }

  //-------------------------------------------------------------------------- favorite

  Widget favorite_bt_gallery( ) {
    return  InkWell(
      onTap: () async {
        await changeStatusOfGalleryFavorite( );
      },
      child: favoriteView(imageGallery),
    );
  }


  Widget favoriteView(MImageGallery  imageGallery){

   // Log.i( "favoriteView() - m: " + imageGallery.toString() );

    //chose icon status color
    var colorStatus = Colors.white;
    if( ToolsAPI.isSuccess( imageGallery.favorite ) ) {
      colorStatus = HexColor( ColorProject.red );
    }

    return CircleAvatar(
        backgroundColor: HexColor(ColorProject.blueCerulean_1),
        radius: 13,
        child: Icon(
          Icons.favorite,
          size: 15,
          color: colorStatus,
        ));
  }





}