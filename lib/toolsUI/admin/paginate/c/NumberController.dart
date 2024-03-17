
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';


import 'package:flutter/material.dart';
import 'package:umq/toolsUI/admin/paginate/v/PaginateAdminWidget.dart';
import 'package:umq/toolsUI/admin/paginate/v/NumberViewPaginate.dart';
import 'package:umq/toolsUI/admin/paginate/v/PaginateAdminWidget.dart';

extension NumberController on PaginateAdminState {


  //--------------------------------------------------------------------- draw first

  void setupFirstNumber(){
    //remove previous
    listNumberWidget = [];

    //add first number page
    listNumberWidget.add( boxNumber(page: 1, isSelected: true ) );

    //refrseh
    setState(() {

    });
  }

  //--------------------------------------------------------------------- draw list

  void drawListNumberWidget(){
    //remove previous
    listNumberWidget = [];

    //maximue
    int starter = _calculateStarterNeedoShow();
    int counterNeedToShow = _calculateCounterNeedToShow();

    //for loop widget
    int position = 1;
    for( int i = starter ; i <= pageTotal ; i++ ){

      //selected
      bool isCurrentPage = i == currentPage;
      //Log.i( "drawListNumberWidget() - i: " + i.toString() );

      //check arrive maxPage
      if(  i  >= maxPage  ) {
        Log.i( "drawListNumberWidget() - maxPage >= i - maxpage: " +  maxPage.toString()  );
        break;
      }

      //add
      Widget w = boxNumber(page: i, isSelected: isCurrentPage );
      listNumberWidget.add( w );

      //check arrive max needed to show
      if( counterNeedToShow <= position ) {
        break;
      }
      position = position + 1;

    }

    //refresh
    setState(() {

    });
  }


  int _calculateCounterNeedToShow(){
    int max = 7;
    if( DeviceTools.isPortrait( context) ){
      max = 3;
    }
    return max;
  }


  int _calculateStarterNeedoShow(){
    var defaultStarter = 1;
    //check there is not current page
    if( currentPage == 0 ) {
      return defaultStarter;
    }


    //check more than range allowed
    //check max is more than totalBar pages
    // exmaple: current page is 7, while totalBar is 14, i need to show 5 button pages
    //           there is problem to show 7,8,9,10,11,12   because 11,12 not in range
    int getMax = currentPage + _calculateCounterNeedToShow();
    if( getMax > pageTotal ) {
      return getMax - _calculateCounterNeedToShow();
    }

    //check arrive maxPage
    // exmaple: current page is 995, while totalBar is 1001, while max page is 1000,
    //           i need to show 7 button pages
    //             there is problem to show 996,997,998,998,999,1000,1001,1002
    //             because 1001,1002   is over the max page allowed.
    //            at this time i need to show form 993 to 999
    if(  getMax  >= maxPage  ) {
      Log.i( "_calculateStarterNeedoShow() - getMax  >= maxPage  "   );
      return (maxPage ) - _calculateCounterNeedToShow();
    }

    //now start from current page need
    return currentPage;
  }

  //-------------------------------------------------------------------- fix responsive

  void responsiveDrawListNumberWidget(){
    ListenerChangeDeviceSize(context,
        orginal_width: DeviceTools.getWidth( context),
        orginal_height: DeviceTools.getHeight( context ),
        changeCallBack: (widthNew, heightNew) {

          //refresh
          setState(() {
            drawListNumberWidget();
          });
        }
    );
  }



}