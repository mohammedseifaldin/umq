import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';

import '../ChatScrollManager.dart';

extension ChatScrollController  on ChatScrollState {

  //---------------------------------------------------------------- what to do after scroll

  /**
   * call when footer loading more data
   */
    whatToDoScrollDown()  {

    //check there is waiting loadding
    if(loading ) {
    //  Log.i( "whatToDoScrollDown() - stop cause by [loading]");
      return;
    }

     //check before refresh page
     if (mounted == false ){
     //  Log.i( "whatToDoScrollDown() - stop cause by [mounted == false]");
       return;
     }

     //downlaod system not start yet
     if( totalRecord == 0 ) {
      // Log.i( "whatToDoScrollDown() - stop cause by [totalRecord == 0]");
       return;
     }

    //check completed
    if( isCompleteAllPages ) {
    //  Log.i( "whatToDoScrollDown() - stop cause by [isCompleteAllPages]");
      return;
    }

    //there is record still waiting for scrolling
     callBackNextPage();
  }

  //--------------------------------------------------------------------------- call back complete

   void callBackComplete(){
    // Log.i( "callBackComplete()   "  );
     isCompleteAllPages = true;

     //status complete
     setState(() {
       loading = false;
     });

     //calll back
   //  widget.callBack(pageFuture, loading, isCompleteAllPages );
   }


   void callBackNextPage(){
    // Log.i( "callBackNextPage() ");
    //progress
     progressStart();

    //increment next page
    pageFuture = pageFuture + 1;

    //calll back
    widget.callBack(pageFuture, loading, isCompleteAllPages );
  }


  //-------------------------------------------------------------------------- auto start

  Future autoStartPageOneFunction() async {
    if( widget.isAutoStartPageOne == false )return;

    callBackNextPage();
  }

  //----------------------------------------------------------------------- focus

  Future focusToPosition(int position ) async {
   // Log.i( "focusToPosition() - position: " + position.toString() );


    /**
     * //avoid exception:
        E/flutter (28856): [ERROR:flutter/lib/ui/ui_dart_state.cc(198)] Unhandled Exception: 'package:flutter/src/widgets/scroll_controller.dart': Failed assertion:
        line 107 pos 12: '_positions.isNotEmpty': ScrollController not attached to any scroll views.
     */
    if( position == 0 ) return;


    // Get the full content height.
    final contentSize = scrollcontroller.position.viewportDimension + scrollcontroller.position.maxScrollExtent;
  //  Log.i( "focusToPosition() - contentSize: " + contentSize.toString()  );

    // Estimate the target scroll position.
    final target = contentSize * position / currentRecord;
   // Log.i( "focusToPosition() - target: " + target.toString()  );


    // Scroll to that position.
    scrollcontroller.position.animateTo(
      target,
      duration: const Duration(milliseconds: 300), //20000 -- slow   good
      curve: Curves.easeInOut,
    );
  }


  Future focusToFirstItemInNewPage() async {

    //first page not to focus to allow user see the above ads slider
    if( pageFuture == 1 ) return;

    //move down
    int previousRecordEndOn = totalRecord - ChatPaginateConstant.paginator;
    int firstItemInNewRecord = previousRecordEndOn ;
    focusToPosition( firstItemInNewRecord );
  }

    //------------------------------------------------------------------- listener

    void listenerScroll(){
      scrollcontroller.addListener(() {
        var isGoToBottom = scrollcontroller.position.pixels == scrollcontroller.position.maxScrollExtent;
        //Log.i( "listenerScroll() - isGoToBottom: " + isGoToBottom.toString() );
        if (isGoToBottom) {
          whatToDoScrollDown();
        }

      });
    }



}


