
import 'package:umq/toolsUI/admin/paginate_number/logic/NumberController.dart';
import 'package:umq/toolsUI/admin/paginate_number/PaginateNumberWidget.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

extension ButtonNextPreviousController on PaginateNumberState {

  void previousButtonFunction(){

    //change current page
    widget.currentPage = widget.currentPage-1;
    if( widget.currentPage == 0 ) {
      widget.currentPage = 1;
      ToolsToast.i( context,  "No Previous Page Found"  );
    }

    //redraw list numbers
    drawListNumberWidget();

    //call
    widget.paginateNumberChange(widget.currentPage);
  }


  void nextButtonFunction(){
    //change current page
    widget.currentPage = widget.currentPage + 1;

    //check maxPage
    if( widget.currentPage >= widget.maxPage! ) {
      widget.currentPage = widget.maxPage! -1;
      ToolsToast.i( context,  "The max page is: " +widget.maxPage.toString() );
    }

    //check more than totalPage
    if( widget.currentPage > widget.pageTotal ) {
      widget.currentPage = widget.pageTotal;
    }

    //redraw list numbers
    drawListNumberWidget();

    //call
    widget.paginateNumberChange(widget.currentPage);
  }


}