import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/inputMessage/InputMessageView.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/listview/itemlist/ItemMessageView.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/listview/itemlist/MessageViewToolsUI.dart';
import 'package:umq/modules/chat/data/model/MChatMessage.dart';
import 'package:umq/modules/chat/data/modelTools/ToolsMChatMessage.dart';

import 'package:umq/modules/chat/shared/toolsChat/resource/ChatColor.dart';

extension SenderHelperUI on ItemMessageState {

  Widget containerSender( Widget child , double widthContent  ) {


    var sizeBoxValue = _getSizeBoxWidthSender( widthContent );
    var isPutChildInRow = false; //isPutChildInRowDate(sizeBoxValue );

    /**
        must write " + dateAndStatusWidth;" to "SizeBoxValue" due to
        the alignment of layout is End.

        this bug at message type "text"
     */
    // if( isPutChildInRow ) {
    //   sizeBoxValue += dateAndStatusWidth;
    // }

    Widget row_lineTwo = _getRowDateAndStatusSender(isPutChildInRow, child );
    Widget columnAllContent = _getColumnContentSender( child, row_lineTwo, isPutChildInRow );
    Widget cont = _getContainerWithBoarder(columnAllContent, sizeBoxValue );
    return _getBoxSize( cont, sizeBoxValue);
  }

  //----------------------------------------------------------------- private methods

  double _getSizeBoxWidthSender(double widthContent ) {
    // min is text of date "yyy-mm-dd" with status icon
    if( widthContent < dateAndStatusWidth ) {
      // widthContent = 120;
      return widthContent +( dateAndStatusWidth );
    }
    //
    // //case small content
    double maxAllowWidth = DeviceTools.get75PercentageWidth( parentState.context)  ;
    // // var sizeBoxValue = 0.0;
    // if(  (widthContent + dateAndStatusWidth) < maxAllowWidth ) {
    //   // sizeBoxValue = widthContent;
    //   return widthContent  ;
    // }

    //case very big content
    if( widthContent > maxAllowWidth ) {
      // sizeBoxValue = maxAllowWidth;
      return maxAllowWidth ;
    }

    //default
    return widthContent;
  }


  Widget _getBoxSize(Widget cont, double  sizeBoxValue) {
    var box =  SizedBox( child:  cont ,
        width: sizeBoxValue
    );

    //alignment
    return Container( child: box ,
      alignment: Alignment.topRight,
      width: DeviceTools.getWidth(parentState.context),
      // color: Colors.yellow, //test
    );
  }


  Widget _getContainerWithBoarder(Widget columnAllContent, double sizeBoxValue ) {
    //margin +  decoration + align
    var cont = Container( child:  columnAllContent ,
      padding: EdgeInsets.all( 5 ),
      margin: EdgeInsets.only(
        right: DSDimen.space_level_2,
        top: _getMarginTopSender(  ),
      ),
      width: sizeBoxValue  ,
      alignment: Alignment.topRight,
      // color: Colors.green, //test
      decoration: _getDecorationSender(),
    );

    return cont;
  }

  Widget _getColumnContentSender(Widget child, Widget row_lineTwo, bool isPutChildInRow) {
    var columnAllContent = Column(
      // colorBackground: Colors.green, //test
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [

          //check have not need here column
          isPutChildInRow? EmptyView.zero() : child,


          row_lineTwo
        ]);

    return columnAllContent;
  }


  Widget _getRowDateAndStatusSender(bool isPutChildInRow , Widget child ) {
    //in same row
    var childInRowDate = EmptyView.zero();
    if(  isPutChildInRow ) {
      childInRowDate = Container(
        child:  child,
        margin: EdgeInsets.only( left: DSDimen.space_level_4 ),
      );
    }

    // date + status icon
    var txt_date = TextTemplate.t(  ToolsMChatMessage.getHumanDate(mChatMessage) ,
        margin: EdgeInsets.only(
          right: DSDimen.space_level_4 ,
               top: DSDimen.space_level_4 / 2
        ),
        levelDS: LevelDS.l4,
        color: ChatColor.msg_text_color
    );
    var row_lineTwo = RowTemplate.wrapChildren( [

      txt_date,


       getStatusIcon( mChatMessage),
      childInRowDate
    ]);
    return row_lineTwo;
  }


  /**
      case the message is second message in chat with same user not to show margin top
   * example :whatsapp
      when same user write many message above each other, the margin top removed
   */
  double _getMarginTopSender( ) {

    //in all position is zero
    if( position == 0 ) return DSDimen.space_level_3;

    //get previous message
    MChatMessage mMessagePrevious = parentState.listMessageDataOld[ position-1];

    //check case many message above each other
    bool isMySelfSender = ToolsMChatMessage.isSender(mMessagePrevious, parentState.myUserId );
    if( isMySelfSender ) {
      return 3;
    }

    //default
    return DSDimen.space_level_3;
  }



  Decoration _getDecorationSender(){

    var radius = BorderRadiusTools.get( radius_topLeft: 5,
        radius_bottomLeft: 5);

    var dec_container_radius = BoxDecoration(
        border: Border.all(color: ChatColor.messageSender_line_boarder ) ,
        borderRadius: radius ,
        color: ChatColor.messageSender_card_background   //background color
    );

    return dec_container_radius;
  }


}
