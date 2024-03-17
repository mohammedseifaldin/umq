

import 'package:umq/toolsUI/admin/paginate/c/NumberController.dart';
import 'package:umq/toolsUI/admin/paginate/v/PaginateAdminWidget.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

extension ButtonNextPreviousController on PaginateAdminState {

  void previousButtonFunction(){

    //change current page
    currentPage = currentPage-1;
    if( currentPage == 0 ) {
      currentPage = 1;
      ToolsToast.i( context,  "No Previous Page Found"  );
    }

    //redraw list numbers
    drawListNumberWidget();

    //call
    callBack(currentPage);
  }


  void nextButtonFunction(){
    //change current page
    currentPage = currentPage+1;

    //check maxPage
    if( currentPage >= maxPage ) {
      currentPage = maxPage-1;
      ToolsToast.i( context,  "The max page is: " + maxPage.toString() );
    }

    //check more than totalPage
    if( currentPage > pageTotal ) {
      currentPage = pageTotal;
    }

    //redraw list numbers
    drawListNumberWidget();

    //call
    callBack(currentPage);
  }


}