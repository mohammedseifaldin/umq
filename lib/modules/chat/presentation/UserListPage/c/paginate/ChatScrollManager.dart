import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'package:umq/modules/chat/presentation/UserListPage/c/paginate/c/ChatScrollController.dart';
import 'package:umq/modules/chat/presentation/UserListPage/c/paginate/v/ChatScrollingView.dart';


//-------------------------------------------------------------------- public utils

typedef ChatScrollCallBack = Function(int newPage, bool progressStatus, bool isCompleted );

class ChatPaginateConstant {

  static const  paginator = 15;

}

//-------------------------------------------------------------------- widget

class ChatScrollManager extends StatefulWidget {



  // var progressStatus = false; //true: means show progress

  List<Widget> children;
  ChatScrollCallBack callBack;
  ValueChanged<ChatScrollState> stateChange;
  bool isAutoStartPageOne = false; //true: cause on create page start callBack for first page


  ChatScrollManager({required this.children,
    required this.callBack,
    required this.stateChange,
    bool? isAutoStartPageOne
  }){
    isAutoStartPageOne ??= false;
    this.isAutoStartPageOne = isAutoStartPageOne;
  }


  @override
  ChatScrollState createState() {
    var state =  ChatScrollState();
    stateChange(state );
    return state;
  }


}

class ChatScrollState  extends ResumableState<ChatScrollManager> {

  // bool enablePullStatus = true;
  bool loading = false; //true: cause show progress circle
  @override
  int pageFuture = 0;
//  RefreshController refreshController = RefreshController(initialRefresh: false);
  // var currentPage = 0;
  var currentRecord = 0; //how many record now visible
  var totalRecord = 0;
  // var totalPage = 0;
  var isCompleteAllPages = false; //true: means no need to continue download
  var previousCounter = 0; //the previous counter size of list, before invoke the next page

  var scrollcontroller = ScrollController();

  //---------------------------------------------------------------------------- life cycle

  void initState() {
    super.initState();
    listenerScroll();
    autoStartPageOneFunction();
  }

  @override
  Widget build(BuildContext context) {
    return getBuildView();
  }

  //============================================================================
  //                                      PublicMethod
  //============================================================================

  //------------------------------------------------------------ progress

  void progressStart(){
    //progress
    setState(() {
      loading = true;
     // enablePullStatus = false;

      //start
       // refreshController.requestLoading( ); //needMove: true
    });
  }


  void progressEnd_waitForNextScroll(){
  //  Log.i("progressEnd_waitForNextScroll()");
    //progress
    setState(() {
      loading = false;
     // enablePullStatus = true;

      //stop paginate
    //  refreshController.loadComplete();
    });
  }

  //----------------------------------------------------------------- laravel paginate


  void updateCurrentPage(  int currentPage){
    this.pageFuture = currentPage;
  }

  void updateCounterOfLaravel({required int currentPage, required int totalRecord, required int currentRecord}){
    //set values
    this.totalRecord = totalRecord;
    this.pageFuture = currentPage;
    this.currentRecord = currentRecord;// currentPage * LaravelPaginateConstant.paginator;

    //set value of completed
    if( totalRecord <= currentRecord ) {
      isCompleteAllPages = true;
    }

    //log
   // Log.i( "updateCounterOfLaravel() - totalRecord: " + totalRecord.toString() );
   // Log.i( "updateCounterOfLaravel() - currentPage: " + currentPage.toString() );
   // Log.i( "updateCounterOfLaravel() - currentRecord: " + currentRecord.toString() );
   // Log.i( "updateCounterOfLaravel() - isCompleteAllPages: " + isCompleteAllPages.toString() );

    //what to do in in every case
    if( isCompleteAllPages ) {
      /**
          focusToPosition( previousCounter);
        */

      callBackComplete();
    } else {
      /**
          focusToFirstItemInNewPage();
        */

      //progress end
      progressEnd_waitForNextScroll();
    }

    //set previous
    previousCounter = currentRecord;
  }



}