
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'package:umq/modules/notification/data/response/ResponseNotificationList.dart';
import 'package:umq/modules/notification/data/response/ResponseNotificationListPaginate.dart';
import 'package:umq/modules/notification/presentation/customer/NotificationListPage/c/NotificationListController.dart';
import 'package:umq/modules/notification/presentation/customer/NotificationListPage/v/views/ItemListNotification.dart';

import 'package:umq/toolsUI/navigation/m/EnumNavigationPage.dart';
import 'package:umq/toolsUI/toolbarHome/ToolbarHomeScuba.dart';
import 'package:umq/toolsUI/background/BackgroundFastorPageTemplate.dart';
import 'package:umq/toolsUI/buttons/ButtonLoginGuestView.dart';

import 'package:umq/tools/fcm/abdo/FCMRegister.dart';
import 'package:umq/tools/resourceProject/DrawableProject.dart';
import 'package:umq/tools/constant/EnvironmentConstant.dart';
import 'package:umq/toolsUI/navigation/v/NavigationScuba.dart';

class NotificationPage extends StatefulWidget {

  @override
  NotificationState createState() {
    return NotificationState();
  }

}

class NotificationState extends ResumableState<NotificationPage> {

  //-------------------------------------------------------------------- variable

  var progress = false;

  bool isGuest = false;

  ResponseNotificationList? response;

  /**
   when to show
      1- after download the api, there is no notificationAdmin found
      2- while progress download the api
   */
  bool isNotFoundNotification = true;

  //---------------------------------------------------------------------- life style

  @override
  void onReady() {
    super.onReady();
    onResume();
  }


  @override
  void onResume() {
    super.onResume();
  }


  @override
  void initState()    {
    super.initState();
    startApiGetList();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await setupFcmFromMainPage(context);
    });
  }

  //-------------------------------------------------------------------- build

  @override
  Widget build(BuildContext context) {
    return PageTemplate.t( this ,
      content: getContent(),

      //fixed background
      widgetBackground: BackgroundCardPage( toolbarHeight: ToolbarHomeScuba.frameHeight ),

      //toolbar
      toolbar: ToolbarHomeScuba( context , title: "Notification" ),
      toolbar_height: ToolbarHomeScuba.frameHeight   ,

      //navigation
      navigationBottom: NavigationBarButtonsScuba( context, EnumNavigationPage.notification ),
      navigationBottom_height: NavigationBarButtonsScuba.frame_height ,
    );
  }


  Widget getContent(){

    //check isGuest
    if( isGuest ) {
      return ButtonLoginGuestView( context);
    }

    // check No notificationAdmin
    if( isNotFoundNotification || progress ) {
      //return noNotificationFoundView();
      return placeHolderLogo();
    }

    //show list
    return getListView();
  }

    //------------------------------------------------------------------- list view

  Widget getListView(){
    return ListViewTemplate.t(
        context: context,
        children: getListWidgetNotification(),
        axis: Axis.vertical );
  }

  List<Widget> getListWidgetNotification() {
    List<Widget> ls = [];
    if( response == null ) return ls;
    if( response!.data!.length == 0 ) return ls;

    //for loop
    response!.data!.forEach((mNotificationAdmin ) {
      var w = getItemListNotification( mNotificationAdmin);
      ls.add( w );
    });

    return ls;
  }


  //------------------------------------------------------------------- place holder

  Widget placeHolderLogo(){

    //place holder
    var img = ImageViewTemplate(context: context,
        assetAspectRatio: DrawableProject.images( "logo"),
        widthNeeded: 180, heightNeeded: 180);

    //progress ui
    var progressView = EmptyView.zero();
    if( progress ) {
      progressView = ProgressSpinkit.get();
    }

    //stack
    return Stack( children: [
      EmptyView.allDeviceScreen(context),

      //image logo
      Positioned(child:  img, left: 0, right:  0, top: 160, ),

      //progress
      Positioned(child: progressView, left: 0, right: 0 , top: 30,)

    ],);
  }


}