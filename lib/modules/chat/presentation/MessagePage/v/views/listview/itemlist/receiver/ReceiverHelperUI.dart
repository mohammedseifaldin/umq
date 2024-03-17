import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/listview/itemlist/ItemMessageView.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/listview/itemlist/MessageViewToolsUI.dart';
import 'package:umq/modules/chat/data/model/MChatMessage.dart';
import 'package:umq/modules/chat/data/modelTools/ToolsMChatMessage.dart';
import 'package:umq/modules/chat/shared/toolsChat/resource/ChatColor.dart';
import 'package:umq/toolsUI/textField/TextFieldWidthGetter.dart';

extension ReceiverHelperUI on ItemMessageState {

  Widget containerReceiver( Widget child , double widthContent  ) {

    var sizeBoxValue = _getSizeBoxWidthReceiver( widthContent );
   // Log.i( "containerReceiver() - sizeBoxValue: " + sizeBoxValue.toString() );

    var isPutChildInRow = false;  // isPutChildInRowDate(sizeBoxValue );
    Widget row_lineTwo = _getRowDateAndStatusReceiver(isPutChildInRow, child );
    Widget columnAllContent = _getColumnContentSender( child, row_lineTwo, isPutChildInRow );
    Widget cont = _getContainerWithBoarder(columnAllContent, sizeBoxValue );
    return _getBoxSize( cont, sizeBoxValue, isPutChildInRow);
  }

  //----------------------------------------------------------------- private methods

  double _getSizeBoxWidthReceiver(double widthContent ) {

    // minimue is text of date "yyy-mm-dd" with status icon
    double dateWidth = 125;
    /**
     - android: is 120
     - ios is : 123
     */
    if( widthContent < dateAndStatusWidth ) {
      // widthContent = 120;
      return widthContent + dateAndStatusWidth;
    }


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




  Widget _getBoxSize(Widget cont, double  sizeBoxValue, bool isPutChildInRow) {
   // Log.i( "_getBoxSize() - m " + mChatMessage.text! + " /size: " + sizeBoxValue.toString() );

    var box =  SizedBox( child:  cont ,
        width: sizeBoxValue
    );

    //alignment
    return Container( child: box ,

      //width: DeviceTools.getWidth(parentState.context),
      // color: Colors.yellow, //test
    );
  }


  Widget _getContainerWithBoarder(Widget columnAllContent, double sizeBoxValue ) {
    //margin +  decoration + align
    var cont = Container( child:  columnAllContent ,
      padding: EdgeInsets.all( 5 ),
      margin: EdgeInsets.only(
        left: DSDimen.space_level_2,
        top: _getMarginTopReceiver(  ),
      ),
      width: sizeBoxValue,
      alignment: Alignment.topRight,
      // color: Colors.green, //test
      decoration: _getDecorationReceiver(),
    );

    return cont;
  }


  Widget _getColumnContentSender(Widget child, Widget row_lineTwo, bool isPutChildInRow) {
    var columnAllContent = ColumnTemplate.t(
      // colorBackground: Colors.green, //test
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //check have not need here column
          isPutChildInRow? EmptyView.zero() : child,


          row_lineTwo
        ]);

    return columnAllContent;
  }


  Widget _getRowDateAndStatusReceiver(bool isPutChildInRow , Widget child ) {
    //in same row
    var childInRowDate = EmptyView.zero();
    if(  isPutChildInRow ) {
      childInRowDate = Container(
        child:  child,
        margin: EdgeInsets.only( right: DSDimen.space_level_4 ),
      );
    }

    // date + status icon
    var txt_date = TextTemplate.t(  ToolsMChatMessage.getHumanDate(mChatMessage) ,
        margin: EdgeInsets.only(
          left: DSDimen.space_level_4 ,
               top: DSDimen.space_level_4 /2
        ),
        levelDS: LevelDS.l4,
        color: ChatColor.msg_text_color
    );
    var row_lineTwo = RowTemplate.wrapChildren( [
      childInRowDate,

      /**
       * no status icon in receiver message :
       *
          getStatusIcon( mChatMessage),
       */

      txt_date,


    ]);
    return row_lineTwo;
  }


  /**
      case the message is second message in chat with same user not to show margin top
   * example :whatsapp
      when same user write many message above each other, the margin top removed
   */
  double _getMarginTopReceiver( ) {

    //in all position is zero
    if( position == 0 ) return DSDimen.space_level_3;

    //get previous message
    MChatMessage mMessagePrevious = parentState.listMessageDataOld[ position-1];

    //check case many message above each other
    bool isTwoReceiverAboveEachOther = ToolsMChatMessage.isReceiver(mMessagePrevious, parentState.myUserId );
    if( isTwoReceiverAboveEachOther ) {
      return 3;
    }

    //default
    return DSDimen.space_level_3;
  }



  Decoration _getDecorationReceiver(){

    var radius = BorderRadiusTools.get( radius_topRight: 5,
        radius_bottomRight: 5);

    var dec_container_radius = BoxDecoration(
        border: Border.all(color: ChatColor.messageReceiver_line_boarder ) ,
        borderRadius: radius ,
        color: ChatColor.messageReceiver_card_background
    );


    return dec_container_radius;
  }



}