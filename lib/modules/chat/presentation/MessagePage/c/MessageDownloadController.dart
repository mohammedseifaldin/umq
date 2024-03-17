import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/chat/presentation/MessagePage/c/ProgressMessageController.dart';
import 'package:umq/modules/chat/presentation/MessagePage/c/ScrollMessageController.dart';
import 'package:umq/modules/chat/presentation/MessagePage/c/UserProfileController.dart';
import 'package:umq/modules/chat/presentation/MessagePage/c/WaiterMessageController.dart';
import 'package:umq/modules/chat/presentation/MessagePage/m/MapDataChatMessage.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/ChatMessagePage.dart';
import 'package:umq/modules/chat/presentation/UserListPage/c/paginate/ChatScrollManager.dart';

import 'package:umq/modules/chat/data/model/MChatMessage.dart';
import 'package:umq/modules/chat/data/source/message/ChatMessageGetAPI.dart';
import 'package:umq/tools/cache/user_single_tone.dart';

import 'package:umq/toolsUI/toast/ToastTools.dart';

extension MessageDownloadController on ChatMessageState {

  Future startGetMessage() async {

    //set my user id
    myUserId = await UserSingleTone.instance().getUserId();


    //validate
    if( _validate() == false ) {
      return;
    }

    // progress
    startProgress();

    //api
    await _apiGetPreviousChat();
  }


  bool _validate() {
    bool result = true;

    //check same user id chat with himself
    bool sameTarget = myUserId == chatTargetId;
    bool typeIndividual = widget.isTypeGroup == false;
    if(  sameTarget && ( typeIndividual) ) {

      caseChatWithYourSelf();
      return false;
    }

    return result;
  }

  void caseChatWithYourSelf() {
    ToolsToast.i(context, "Not allowed Chat with yourself");

    //wait then close page
    ToolsWait.waitToDo(100, () {
      Navigator.pop(context);
    } );
  }

  Future _apiGetPreviousChat() async {
    ChatMessageGetAPI().getData(page: page,
        paginator: ChatPaginateConstant.paginator,
      target: chatTargetId,
      callBack: ( status, msg, isFinishAllPages, response )  async {


        this.isFinishAllPages = isFinishAllPages;

        //waitier start
        await initWaiterMessage();

        // progress
        await stopProgress();

        //update user profile
        await updateUserProfile( response.userTargetSmall );

        //check
        if( status == false ) {
       //    ToolsToast.i(context, msg);
            return;
          }

        //calculate next page
        await _calculateNextPage();

          //check have data
        if( response.data == null ) return;

        //date data
        List<MChatMessage> listNew = response.data!.data!;

        // append data
        await appendedHistoryData( listNew);

        //map view
        await mapObjectToView( );

        // update ui
       await typeAddNewPageHistory();



      }

    );
  }

  Future _calculateNextPage() async {
    page = page +1;
  //  paginator = 5; //any next page will be 5
  }

}