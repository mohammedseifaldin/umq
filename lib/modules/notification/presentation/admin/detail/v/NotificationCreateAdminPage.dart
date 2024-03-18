
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'package:umq/modules/notification/presentation/admin/detail/v/views/ContentUserDetail.dart';
import 'package:umq/modules/notification/presentation/admin/detail/v/views/SpinnerSelectTypeTopic.dart';
import 'package:umq/modules/profile/data/model/m_user.dart';
import 'package:umq/tools/responsive/fourm/ResponsiveFormMobile.dart';
import 'package:umq/toolsUI/textfield/mobileCountry/MobileCountryView.dart';
//import 'package:umq/toolsUI/toolbar/ToolbarSimpleFastor.dart';

class NotificationCreateAdminPage extends StatefulWidget {

  @override
  NotificationCreateAdminState createState() {
    return NotificationCreateAdminState(   );
  }


}

class NotificationCreateAdminState extends ResumableState<NotificationCreateAdminPage > {

  //-------------------------------------------------------------------- variable
  String pageTitle = "Create Notify";

  //topic
  String topicSelectedType = "";
  MUser? userSelected ;

  //name
  var title_txt = "";
  var title_valid = AutovalidateMode.disabled;
  var title_controller = TextEditingController();

  //email
  var message_txt = "";
  var message_valid = AutovalidateMode.disabled;
  var message_controller = TextEditingController();

  //mobile
  MobileCountryViewState? mobileState;

  //------------------------------------------------------------------- life cycle


  @override
  void initState() {
    super.initState();

  }


  @override
  void onReady() {
    super.onReady();
    onResume();
  }


  @override
  void onResume(){
    super.onResume();
    //Log.i( "lifecycle - onResume - cityDetail");
  }


  //-------------------------------------------------------------------- build

  BuildContext? contextPage;
   ProgressCircleState? prg;

  @override
  Widget build(BuildContext context) {
    this.contextPage = context;

    return getPageTemplate();
  }


  Widget getPageTemplate(){

    return PageTemplate.t( this,
        title: pageTitle,
        content: pageContent(),
        // assetBackgroundOpacity: 0.3,
        // assetBackground: DrawableProject.exampleAdmin(  "01"),
        toolbar: ToolbarSimpleFastor(  context,  pageTitle, iconColorBack: Colors.black ),
        toolbar_height: ToolbarSimpleFastor.frameHeight,
        onChangeProgressState: (value) => prg = value
    );
  }


  Widget pageContent() {
    return ResponsiveFourmMobile.wrapHeight(  context, getContent() );
  }

  Widget getContent() {
    return ColumnTemplate.t( children: [
      spinner_topic(),
      title(),
      message(),
      save()
    ],
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.max,
    crossAxisAlignment: CrossAxisAlignment.start
    );
  }


}