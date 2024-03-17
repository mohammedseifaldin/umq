
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/teachers/data/model/MVideoGallery.dart';
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/modules/teachers/data/response/ResponseGalleryUpdateFavorite.dart';
import 'package:umq/modules/teachers/data/response/ResponseSingleTeacher.dart';
import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/toolsUI/dialog/CheckoutLoginDialog.dart';
import 'package:umq/toolsUI/itemList/gallery/video/c/ItemVideoGalleryController.dart';
import 'package:umq/toolsUI/itemList/gallery/video/m/GalleryVideoFavoriteAPI.dart';
import 'package:umq/toolsUI/video/VideoPageFullScreen.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/tools/network/ToolsAPI.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

class ItemVideoGallery extends StatefulWidget {

  BuildContext pageContext;
  MVideoGallery m;
  ItemVideoGallery( this.pageContext, this.m);

  @override
  ItemVideoGalleryState createState() {
    return ItemVideoGalleryState( m );
  }

}

class ItemVideoGalleryState extends State<ItemVideoGallery> {

  MVideoGallery m;
  ItemVideoGalleryState(this.m);

  Widget build(BuildContext context) {
    return  itemVideoGallery(  );
  }


  Widget itemVideoGallery( ){
    return Stack(
      children: [

        thump(),
        bt_favorite(),
        bt_play(),
      ],
    );
  }

  Color getColorOfFavoirteIcon(MVideoGallery  m ) {
    if( ToolsAPI.isSuccess( m.favorite) ) {
      return HexColor( ColorProject.red);
    } else {
      return Colors.white;
    }
  }

  //-------------------------------------------------------------------- image or play

  Widget bt_play() {
    return  Positioned(
      top: 10,
      left: 10,
      child: InkWell(
        onTap: () {

          GoTo.videoFullScreen( widget.pageContext, m.file!  );

        },
        child: CircleAvatar(
            backgroundColor: HexColor( ColorProject.blueCerulean_1),
            radius: 13,
            child: Icon(
              Icons.play_arrow,
              size: 15,
              color: Colors.white,
            )),
      ),
    );
  }

  Widget thump(){
    return  InkWell(
      onTap: () {
        GoTo.videoFullScreen( widget.pageContext, m.file!  );

      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          child: Image.network(m.thump!),
        ),
      ),
    );
  }

  //--------------------------------------------------------------------------------- favoirte

  Widget bt_favorite() {
    return  Positioned(
      left: 10,
      top: 45,
      child: InkWell(
        onTap: () async {
        //  await apiFavoriteGalleryVideo();
          await changeStatusOfGalleryFavorite( );
        },
        child: CircleAvatar(
            backgroundColor: HexColor( ColorProject.blueCerulean_1) ,
            radius: 13,
            child: Icon(
              Icons.favorite,
              size: 15,
              color: getColorOfFavoirteIcon(m),
            )),
      ),
    );
  }




}