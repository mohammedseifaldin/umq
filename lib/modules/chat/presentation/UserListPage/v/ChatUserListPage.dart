import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'package:umq/modules/chat/data/model/MChatUser.dart';
import 'package:umq/modules/chat/presentation/UserListPage/c/WaiterUserListController.dart';
import 'package:umq/modules/chat/presentation/UserListPage/c/paginate/ChatScrollManager.dart';
import 'package:umq/modules/chat/presentation/UserListPage/v/views/ListViewUser/ListUserView.dart';
import 'package:umq/modules/chat/shared/toolsChat/resource/ChatColor.dart';
import 'package:umq/modules/chat/shared/toolsChat/singletone/lifeCycle/LifeCycleSingletone.dart';
import 'package:umq/modules/chat/shared/toolsChat/singletone/message/NewMessageSingleTone.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/fcm/abdo/FCMRegister.dart';
import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/toolsUI/textview/ErrorMessageView.dart';

import 'views/toolbar/ToolbarChatHome.dart';

class ChatUserListPage extends StatefulWidget {
  int? navigateToSpecificUserId; //when have value go to specific user id

  static int pageScroll = 1;

  ChatUserListPage({super.key, int? navigateToSpecificUserId}) {
    this.navigateToSpecificUserId = navigateToSpecificUserId;
  }

  @override
  ChatUserListState createState() {
    return ChatUserListState();
  }
}

class ChatUserListState extends ResumableState<ChatUserListPage> {
  //--------------------------------------------------------------------- varaible

  //user list
  List<MChatUser> listUserData = [];
  List<Widget> listUserWidget = [];

  //progress and paginate controller
  ChatScrollState? paginateState; //controller the progress of user list

  //error msg
  String? errorMsg;

  //--------------------------------------------------------------------- life cycle

  @override
  void onReady() {
    super.onReady();
    onResume();
    Log.i("ChatUserListPage - onResume");
  }

  @override
  void onResume() {
    super.onResume();
    Log.i("ChatUserListPage - onResume");

    //set life
    LifeCycleSingletone.instance().setChatListPage(this);
  }

  @override
  void initState() {
    super.initState();
    Log.i("ChatUserListPage - initState");

    //set life
    LifeCycleSingletone.instance().setChatListPage(this);

    //waiter of socket
    initWaiter();

    // guest
    initIsGuestUser();

    //start socket
    NewMessageSingleTone.instance()
        .startSocketMessageAndDownloadFirstPageData();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await setupFcmFromMainPage(context);
    });
  }

  //--------------------------------------------------------------------- build

  @override
  Widget build(BuildContext context) {
    return PageTemplate.t(this,
        title: "Chats",
        //resizeToAvoidBottomInset: false,
        //status
        statusBarColorCustom: ChatColor.statusBarColor,

        //home button theme
        homeButtonsBackgroundColor: ChatColor.homeButtonBarColor,

        // assetBackground: DrawableProject.exampleMobile( "example_chat"),
        // assetBackgroundOpacity: 0.6,
        toolbar: ToolbarChatHome(context, "Chats"),
        toolbar_height: ToolbarChatHome.toolbarHome_height,
        content: getContent());
  }

  Widget getContent() {
    //check guest
    if (isGuest) {
      return guestView();
    }

    //check error
    if (ToolsValidation.isValid(errorMsg)) {
      return ErrorMessageView(errorMsg!);
    }

    return ColumnTemplate.t(children: [
      // dialogSyncLargeData(),
      listUserView()
    ]);
  }

  //----------------------------------------------------------------- guest

  bool isGuest = false;

  void initIsGuestUser() async {
    isGuest = UserSingleTone.instance().isGuest();
    if (isGuest) {
      setState(() {});
    }
  }

  Widget guestView() {
    return TextTemplate.t("Login First",
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 50),
        color: DSColor.link, onPressed: () {
      GoTo.splashLogin(context);
    });
  }
}
