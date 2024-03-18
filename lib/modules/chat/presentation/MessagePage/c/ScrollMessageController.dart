import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/chat/presentation/MessagePage/c/FloatButtonNewMessageController.dart';
import 'package:umq/modules/chat/presentation/MessagePage/c/MessageDownloadController.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/ChatMessagePage.dart';

extension ScrollMessageController on ChatMessageState {
  //----------------------------------------------------------------------- listener

  Future startScrollListener() async {
    scrollController.addListener(() async {
      //set previous
      // var current = scrollController.position.pixels;
      // Log.i( "addListener - current: " + current.toString() );

      //for scroll at top
      if (scrollController.position.pixels ==
          scrollController.position.minScrollExtent) {
        await _whatToDoAfterArriveTopScreen();
      }

      //for scroll to bottom
      bool isGoToBottom = scrollController.position.pixels ==
          scrollController.position.maxScrollExtent;
      if (isGoToBottom) {
        await setHideFloatButtonNow();
      }
    });
  }

  Future _whatToDoAfterArriveTopScreen() async {
    //check is waiting
    if (isWaitingForPreviousLoading) return;

    //check is finish all pages pagination
    if (isFinishAllPages) return;

    //now start next
    startGetMessage();
  }

  //--------------------------------------------------------------- history added

  Future typeAddNewPageHistory() async {
    //set previous
    scrollPreviousPositionMaxLenght = scrollController.position.maxScrollExtent;
    Log.i("typeAddNewPageHistory() - scrollPreviousPosition_maxLenght: " +
        scrollPreviousPositionMaxLenght.toString());

    //1- show list
    setState(() {});

    //2- focus to scroll view
    await ToolsWait.waitToDo(100, () async {
      await _chooseFocusTypeAferHistoryAdded();
    });
  }

  Future _chooseFocusTypeAferHistoryAdded() async {
    /***
        a- case first page :
        focus to bottom of screen
        (notice: first page is take number 2, because the varaible take next future page counter

        b- case second page or third page or above now user need to see history of chat
        then need to foucs to top of screen

        c- case last page in history
     */
    Log.i("_startFocus() - page: " + page.toString());
    if (page == 2) {
      await focusNowBottomScreenWithAnimate();
    } else if (isFinishAllPages) {
      // await focusNowTopScreenRapid();
      await focusToPreviousPosition();
    } else {
      // await focusTopMinesSomeRows();
      await focusToPreviousPosition();
    }
  }

  //--------------------------------------------------------------- socket waiter added

  Future scrollEventSocketWaiterAdded() async {
    //2- focus to scroll view
    await ToolsWait.waitToDo(100, () async {
      await _chooseFocusTypeAfterWaiterAdded();
    });
  }

  Future _chooseFocusTypeAfterWaiterAdded() async {
    //check socketFoundNewMessage
    if (socketFoundNewMessageIamSender) {
      bool isFirstPage = page == 2;
      if (isFirstPage) {
        await focusNowBottomScreenWithAnimate();
      }
      return;
    }
  }

  //---------------------------------------------------------------- focus types

  Future focusNowBottomScreenWithAnimate() async {
    double max = scrollController.position.maxScrollExtent;
    Log.i("focusNowBottomScreenWithAnimate() - max: " + max.toString());

    // Scroll to that position.
    scrollController.position.animateTo(
      max,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  /**
   jump immedialty without animate
   */
  Future focusBottomScreenRapid() async {
    double max = scrollController.position.maxScrollExtent;
    // Log.i( "focusBottomScreenRapid() - max: " + max.toString()  );

    // Scroll to that position.
    scrollController.position.animateTo(
      max,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }

  Future focusNowTopScreenRapid() async {
    Log.i("focusNowTopScreenRapid() ");
    scrollController.position.animateTo(
      0,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }

  Future focusToPreviousPosition() async {
    var currentMax = scrollController.position.maxScrollExtent;
    var distanceAddedNew = currentMax - scrollPreviousPositionMaxLenght;
    Log.i("focusToPreviousPosition() - scrollPreviousPosition: " +
        scrollPreviousPositionMaxLenght.toString());
    Log.i("focusToPreviousPosition() - distanceAddedNew: " +
        distanceAddedNew.toString());

    scrollController.position.jumpTo(distanceAddedNew);
  }
}


/**
    Future focusTopMinesSomeRows() async {
    Log.i( "focusTopMinesSomeRows() "   );

    //scroll to -five
    /**
 * why -2?
 *  to see the first last in list
    */
    final positionGoTo = ChatPaginateConstant.paginator - 2;
    final sizeItem =  listMessageData.length;
    final max = scrollController.position.maxScrollExtent;
    final contentSize = scrollController.position.viewportDimension + max;
    final singleItemHeight = contentSize/ sizeItem;
    final targetIndex = positionGoTo * singleItemHeight;

    //jump
    scrollController.position.jumpTo( targetIndex );

    }



 */