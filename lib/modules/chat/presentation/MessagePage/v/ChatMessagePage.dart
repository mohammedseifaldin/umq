import 'dart:async';

import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'package:umq/modules/profile/data/model/m_user.dart';
import 'package:umq/modules/chat/data/source/message/ChatMessageCreateAPI.dart';

import 'package:umq/modules/chat/presentation/MessagePage/c/MessageDownloadController.dart';
import 'package:umq/modules/chat/presentation/MessagePage/c/ScrollMessageController.dart';
import 'package:umq/modules/chat/presentation/MessagePage/c/WaiterMessageController.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/floatButton/FloatButtonNewMessageView.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/inputMessage/InputMessageView.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/listview/ListViewMessage.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/listview/itemlist/ItemMessageView.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/toolbarMessage/MessageToolbar.dart';
import 'package:umq/modules/chat/presentation/UserListPage/c/paginate/ChatScrollManager.dart';
import 'package:umq/modules/chat/data/model/MChatMessage.dart';
import 'package:umq/modules/chat/data/model/MChatUser.dart';

import 'package:umq/modules/chat/shared/toolsChat/resource/ChatColor.dart';
import 'package:umq/modules/chat/shared/toolsChat/singletone/lifeCycle/LifeCycleSingletone.dart';
import 'package:umq/tools/resourceProject/DrawableProject.dart';
import 'package:umq/tools/audio/RecorderSoundInstance.dart';
import 'package:umq/tools/audio/sound/SoundSingleTone.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';


int chatTargetId = 0 ;  //user id target to chat with him
ChatMessageState? myStateChatMessagePage;

class ChatMessagePage extends StatefulWidget {


  bool isTypeGroup = false ; //not used until version 1 chat

   MChatUser? mChatUser;
   MUser? userTargetSmall;


  ChatMessagePage({
    required int targetId,
    required bool isTypeGroup,
    MChatUser? mChatUser
}) {
    chatTargetId = targetId;
    this.isTypeGroup = isTypeGroup;

    //set chat user
    this.mChatUser = mChatUser;
    if( this.mChatUser != null  ){
      userTargetSmall = mChatUser!.user!;
    }

  }


  @override
  ChatMessageState createState() {
    myStateChatMessagePage = ChatMessageState();
    return myStateChatMessagePage!;
  }

}


class ChatMessageState extends ResumableState<ChatMessagePage > {

  //----------------------------------------------------------------------- varaible

  //data
  List<Widget> listMessageViewOld = [];
  List<MChatMessage> listMessageDataOld = [];
  // List<Widget> listMessageViewNew = [];
  // List<MChatMessage> listMessageDataNew = [];

  //my user
  int myUserId = 0;

  //paginate
  int page = 1;

  bool isFinishAllPages = false;

  //stream
  // Stream<MChatMessage> myStream = Stream() ;

  //scroll
  var scrollController = new ScrollController();
  var isWaitingForPreviousLoading = false;
  var scrollPreviousPosition_maxLenght = 0.0;

  //progress
  var progressStatus = false;

  //toolbar
  MessageToolbarState? stateToolbar;

  //float button
  var floatButtonStatus = false;

  //socket waiter
  var isStartWaiterBefore = false;
  var socketFoundNewMessageIamSender = false;

  //state
  StateSetter? innerState;

  //----------------------------------------------------------------------- recorder instance

  RecorderSoundInstance? recorderSoundInstance;

  void initRecorder() {
    recorderSoundInstance = RecorderSoundInstance();
  }

  //----------------------------------------------------------------------- life cycle

  @override
  void onResume() {
    super.onResume();
    Log.i("ChatMessagePage - onResume");

    //set life
    LifeCycleSingletone.instance().setChatMessagePage( this  );
  }


  @override
  void initState() {
    super.initState();
    Log.i("ChatMessagePage - initState");

    startGetMessage();
    startScrollListener();
    initRecorder();
  }

  //----------------------------------------------------------------------- download

  Future apiCreateMessage(MChatMessage mMessageNew) async {

    await ChatMessageCreateAPI().createNew(mMessageNeeded: mMessageNew,
        callBack: (status, msg, response ) async {

          //check failed
          if( status == false ) {
            ToolsToast.i(context, msg);
            return;
          }


          //wait socket return the data
          ToolsWait.waitToDo( 50, ()  async {
            //focus
            await focusBottomScreenRapid();
          });


        });
  }

  //----------------------------------------------------------------------- build

  @override
  Widget build(BuildContext context) {

    return PageTemplate.t( this,
        title: "Message",

        //status
        statusBarColorCustom : ChatColor.statusBarColor,

        //home button theme
        homeButtonsBackgroundColor: ChatColor.homeButtonBarColor,

        //toolbar
        toolbar: MessageToolbar( context, widget.userTargetSmall, (s ) => stateToolbar = s ),
        toolbar_height: MessageToolbar.height_Frame,

        // example
        // assetBackground: DrawableProject.exampleMobile( "whatsapp_message"),
        // assetBackgroundOpacity: 0.6,

        //bottom
        navigationBottom: InputMessageWidget( this ),
        navigationBottom_height:  InputMessageState.height_Frame,

        //float
        floatBottom: getFloatButtonNewMessage(),

        //scroll
        scrollController: scrollController,

        //content
        content: getContent() );
  }


  Widget getContent(){
    return Stack( children: [

      EmptyView.allDeviceWidth(context),

      //test
      // TextTemplate.t( "target user id : " + ChatMessagePage.targetId.toString()  ),

      //list message
      getListViewMessage(),

      //progress
      getProgresView(),

    ],);
  }

  Widget getProgresView(){
    //check show or not
    if( progressStatus == false ) {
      return EmptyView.zero();
    }

    //view
    var prg = ProgressSpinkit.get();
    return Container( child:  prg,
      width: DeviceTools.getWidth(context),
      alignment: Alignment.center,
    );
  }


}