import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/chat/presentation/UserListPage/c/DownloadListUserPaginateController.dart';
import 'package:umq/modules/chat/presentation/UserListPage/c/paginate/ChatScrollManager.dart';
import 'package:umq/modules/chat/presentation/UserListPage/v/ChatUserListPage.dart';

extension ListUserView on ChatUserListState {

  Widget listUserView(){
    return  paginatePageWidget();
  }

  //------------------------------------------------------------------------------ paginate

  Widget paginatePageWidget(){
   // Log.i("paginatePageWidget() - listUserWidget: " + listUserWidget.length.toString()  );

    return ChatScrollManager(
      children: listUserWidget,
      isAutoStartPageOne: true,
      stateChange: (state){
        paginateState = state;
      },
      callBack: (int newPage, bool progressStatus, bool isCompleted) async {
        Log.i("paginatePageWidget() - newPage: " + newPage.toString()
            + " /isCompleted: " + isCompleted.toString()  );

        //set current page
        ChatUserListPage.pageScroll = newPage;

        //get data
        await getUserPage( newPage  );
      },
    );
  }




}