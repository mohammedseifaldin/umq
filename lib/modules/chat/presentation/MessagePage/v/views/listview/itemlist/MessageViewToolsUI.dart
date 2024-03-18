import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/chat/data/model/MChatMessage.dart';
import 'package:umq/modules/chat/data/modelTools/ToolsMChatMessage.dart';
import 'package:umq/modules/chat/presentation/MessagePage/c/itemList/ItemListRecorderController.dart';
import 'package:umq/modules/chat/shared/toolsChat/constant/ToolsEnumReadStatus.dart';
import 'package:umq/modules/chat/shared/toolsChat/resource/ChatColor.dart';
import 'package:umq/modules/chat/shared/toolsChat/resource/ChatDrawable.dart';
import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/tools/resourceProject/DrawableProject.dart';

import 'ItemMessageView.dart';


var dateAndStatusWidth = 120.0; //example: "Yesterday xx"
var imageMediaSize = 160.0;

/**
 * android: 120 workng ok
 * ios: need 122 min
 */
double recorderFrameWidth = 125; //

extension MessageViewToolsUI on ItemMessageState {

  //------------------------------------------------------------- message content

  bool isPutChildInRowDate(double sizeBoxValue){
    double maxAllowWidth = DeviceTools.get75PercentageWidth( parentState.context);
    bool isTextFormat = ToolsMChatMessage.isTypeTextOnly( mChatMessage);
    bool isWidthSmall = sizeBoxValue < maxAllowWidth;
    bool isPutChildInRow = isTextFormat && isWidthSmall;
    return isPutChildInRow;
  }

  //-------------------------------------------------------------- line separator

  Widget dateSeparatorLineView(double width ) {
    return Container(

      child: EmptyView.zero(),
      width: width, //DeviceTools.get75PercentageWidth(parentState.context),
      height: DSDimen.space_level_4,
      // margin: EdgeInsets.only( top: DSDimen.space_level_3 ),
      // color: ChatColor.separatorLine,
    );
  }


  //-------------------------------------------------------------- icon message status

  Widget getStatusIcon(MChatMessage mChatMessage ) {

    var imageAsset ;
    double height = 7;
    if( ToolsEnumReadStatus.isReaded(mChatMessage) ) {
      imageAsset = ChatDrawable.images( "status_read");
    } else if (ToolsEnumReadStatus.isWait(mChatMessage)  ) {
      imageAsset = ChatDrawable.images( "wait");
      height = 10;
    } else {
    imageAsset = ChatDrawable.images( "status_send");
    }

    var img_assign = ImageViewTemplate(
      context: parentState.context,
      widthNeeded: 10,
      heightNeeded: height,
      assetAspectRatio: imageAsset,
    );
    return Container( child: img_assign,
       margin: EdgeInsets.only( top:    DSDimen.space_level_4 / 2)
        );
  }

  //------------------------------------------------------------------- media : (image, video )

  Widget imageMessageIm() {

    var image = ImageViewTemplate(context: parentState.context,
      widthNeeded: imageMediaSize,
      heightNeeded: imageMediaSize,
      assetAspectRatio: DrawableProject.placeholderImage,
      // urlAspectRation: mChatMessage.image,
      urlBackground: mChatMessage.image,
      boxFit_background: BoxFit.cover,

      //click
      onPressed: () async {
        String imageUrl = mChatMessage.image!;
        GoTo.fullScreenImage( parentState.context, imageUrl);
      },
    );

    //margin
    return Container( child: image,
        // color: Colors.yellow, //test
       margin: EdgeInsets.only( bottom: DSDimen.space_level_4  )
    );
  }

  //------------------------------------------------------------------- recorder tools

  bool getStatusRecorderStartPlaying(){
    //not all views have stateFullWidget
    if( itemStatefullwidget == null ) return false;
    return itemStatefullwidget!.widget.isRecorderStartPlaying;
  }


  Widget getPlayIconRecorder() {

    //choose icon
    var iconAsset = ChatDrawable.images( "play");
    if( getStatusRecorderStartPlaying() ){
      iconAsset = ChatDrawable.images( "pause");
    }

    //color
    var colorReadStatus  = ChatColor.recorderButton_send;
    bool isReaded = ToolsEnumReadStatus.isReaded(mChatMessage);
    if( isReaded ) {
      colorReadStatus = ChatColor.recorderButton_readed;
    }

    //image icon
    var img =  ImageViewTemplate(context:  parentState.context,
      widthNeeded: 25,
      heightNeeded: 25,
      padding: EdgeInsets.all( 10 ),
      onPressed: () async {
        await playOrPauseRecorder();
      },
      assetBackground: iconAsset,
    );


    //circle shape
    var circleShape =  Container( child:  img,
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoarderHelper.rounded(
          radiusSize: 40,
          colorLine: colorReadStatus,
          colorBackground: colorReadStatus
      ),
      margin: EdgeInsets.all( 5 ),
    );


    //align
    var contAlignmentCenter = Container( child:  circleShape,
      width: recorderFrameWidth,
      alignment: Alignment.center,
    );
    return contAlignmentCenter;
  }


// Widget lineProgressRecorder() {
//
//   //static
//   var colorProgress = Colors.black;
//   var isRead = ToolsEnumReadStatus.isReaded(mChatMessage);
//   if( isRead  || getStatusRecorderStartPlaying() ) {
//     colorProgress = ChatColor.recorderButton_readed;
//   }
//
//   return Container(
//     child: EmptyView.colored( recorderProgressWidth, 10, colorProgress),
//   );
// }



}