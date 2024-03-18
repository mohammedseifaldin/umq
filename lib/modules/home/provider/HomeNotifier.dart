import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/home/data/model/MSlider.dart';
import 'package:umq/modules/home/provider/HomeChangeNotifier.dart';
import 'package:umq/modules/teachers/data/model/MTeacher.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/constant/ConstantProject.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

import '../data/source/HomeApi.dart';




extension HomeNotifier on HomeChangeNotifier   {


  //-------------------------------------------------------------- scroll and download next page.

  Future setupScrollListenerToPaginate(BuildContext context ) async {
    homeScrollController.addListener(() async {
      var isGoToBottom = homeScrollController.position.pixels == homeScrollController.position.maxScrollExtent;

      bool stillNeedData = allDataAdded == false;
      if (isGoToBottom &&  stillNeedData ) {

        Log.i( "setupScrollListenerToPaginate() - _getNextPageHomeResponse: " + _getNextPageHomeResponse().toString() );
        await  downloadNextPage(context);
      }
    });
  }

  void _updateProgress(bool n ) {
    homeProgress = n;
    notifyListeners();
  }


  int _getNextPageHomeResponse(){
    if( responseHomePage == null ) return 1;
    if( responseHomePage.data == null ) return 1;
    if( responseHomePage.data!.teacherData!.data!.isEmpty ) return 1;
    return responseHomePage.data!.teacherData!.currentPage! + 1 ;
  }

  Future downloadNextPage(BuildContext context ) async {

    await _downloadHomePage( context, _getNextPageHomeResponse() );
  }

  //--------------------------------------------------------------  download  first page

  Future downloadFirstPage(BuildContext context) async {
    await _downloadHomePage(context, 1);
  }


  //--------------------------------------------------------------  download

  Future _downloadHomePage(BuildContext context, page) async {

    //progress
    _updateProgress(true);

    //wait downlaod
    HomeApi( context, page, (status, msg, response ){

    //  Log.i( "downloadHomePage()  - status: " + status.toString() );

      if( status== false ) {
        ToolsToast.i(context, msg);

        //progress
        _updateProgress(false);

        return;
      }
      responseHomePage = response;

      //
      setDataResponseToInstanceScope();

    });

  }

  //--------------------------------------------------------------- set data

  Future setDataResponseToInstanceScope() async {

    //clear cache login when token expire
    if( responseHomePage.tokenExpire! ) {
      await UserSingleTone.instance().setLogout();
    }

    //slider : loop data
    if( sliders.length == 0 ) {
      /**
       *   why slider check have data before ?
       *    - because paginatation not working in slider, just pagination for provider list only
       */
      await  resetManuelTheOldSataOfSlider();
    }

    // init
    await initIsLoadAllDataTeacherToStopPaginate();

    // loop data
    await loopDataProvider();

    //progress
    _updateProgress(false);
  }

  Future initIsLoadAllDataTeacherToStopPaginate() async  {

    int total = responseHomePage.data!.teacherData!.total!;
    int expected = responseHomePage.data!.teacherData!.currentPage! * ConstantProject.paginator;

    allDataAdded = expected >=  total;
    Log.i("initIsLoadAllDataTeacherToStopPaginate() - allDataAdded: $allDataAdded /expected: $expected /total: $total");
  }

  Future resetManuelTheOldSataOfSlider( ) async {
    for( int i = 0 ; i < responseHomePage.data!.slider!.length ; i++ ) {
      MSlider mSlider = responseHomePage.data!.slider![i];
      sliders.add( mSlider.image );
    }
  }


  Future loopDataProvider()  async {
    for( int i = 0 ; i < responseHomePage.data!.teacherData!.data!.length ; i++ ) {
      MProvider m = responseHomePage.data!.teacherData!.data![i];
      /**
       * here just appened list
       */
      teachers.add( m );
    }
  }


}

