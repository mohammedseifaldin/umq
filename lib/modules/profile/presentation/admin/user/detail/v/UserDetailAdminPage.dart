
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'package:umq/modules/place/data/model/MCity.dart';
import 'package:umq/modules/profile/data/model/m_user.dart';
import 'package:umq/modules/profile/presentation/admin/user/detail/c/EditUserController.dart';
import 'package:umq/modules/profile/presentation/admin/user/detail/c/UserDownloadAdmin.dart';
import 'package:umq/modules/profile/presentation/admin/user/detail/v/views/ContentUserDetail.dart';
import 'package:umq/tools/responsive/fourm/ResponsiveFormMobile.dart';
import 'package:umq/toolsUI/textfield/mobileCountry/MobileCountryView.dart';
//import 'package:umq/toolsUI/toolbar/ToolbarSimpleFastor.dart';

class UserDetailAdminPage extends StatefulWidget {

  MUser? mEdit  ;

  UserDetailAdminPage( {super.key,  MUser? edit }) {
    mEdit = edit;
  }

  @override
  UserDetailAdminState createState() {
    return UserDetailAdminState( edit: mEdit );
  }


}

class UserDetailAdminState extends ResumableState<UserDetailAdminPage > {

  //-------------------------------------------------------------------- variable
  String pageTitle = "User";
  MUser? mEdit  ;

  //name
  var name_txt = "";
  var name_valid = AutovalidateMode.disabled;
  var name_controller = TextEditingController();

  //email
  var email_txt = "";
  var email_valid = AutovalidateMode.disabled;
  var email_controller = TextEditingController();

  //password
  var password_txt = "";
  var password_valid = AutovalidateMode.disabled;
  var password_controller = TextEditingController();

  //city
  var city_selected_name = "";
  int city_selected_id = 0;
  static List<MCity> city_list = [];

  //mobile
  MobileCountryViewState? mobileState;

  //photo
  String photo_url_selected = "";
  late String photo_pathFile  ;
  ImageViewState? photo_state;
  var photo_progress_status = false ;

  //constructor
  UserDetailAdminState( { MUser? edit }) {
    this.mEdit = edit;
  }

  //------------------------------------------------------------------- life cycle


  @override
  void initState() {
    super.initState();
    // download data
    city_download();
    setEditDataIfFound();
  }


  @override
  void onReady() {
    super.onReady();
    onResume();
  }


  @override
  void onResume(){
    super.onResume();
    Log.i( "lifecycle - onResume - userDetail");
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

    if( mEdit != null ) {
      pageTitle = "Edit" + " " + pageTitle;
    }

    return PageTemplate.t( this,
        title: pageTitle,

        content: pageContent(),
        // assetBackgroundOpacity: 0.3,
        // assetBackground: DrawableProject.exampleAdmin(  "01"),
        toolbar: ToolbarSimpleFastor(  contextPage!,  pageTitle , iconColorBack: Colors.black,),
        toolbar_height: ToolbarSimpleFastor.frameHeight,
        onChangeProgressState: (value) => prg = value
    );
  }


  Widget pageContent() {
    return ResponsiveFourmMobile.wrapHeight(  contextPage!, getContent() );
  }

  Widget getContent() {
    return ColumnTemplate.t( children: [
      name(),
      email(),
     // password(),
      city(),
      mobile(),
      photo(),
      save()
    ],
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.max,
    crossAxisAlignment: CrossAxisAlignment.start
    );
  }


}