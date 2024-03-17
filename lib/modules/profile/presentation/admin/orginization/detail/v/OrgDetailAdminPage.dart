
import 'dart:typed_data';


import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'package:umq/modules/place/presentation/admin/city/detail/c/EditController.dart';
import 'package:umq/modules/place/presentation/admin/city/detail/v/views/ContentUserDetail.dart';
import 'package:umq/modules/profile/presentation/admin/orginization/detail/c/EditController.dart';
import 'package:umq/modules/profile/presentation/admin/orginization/detail/v/views/ContentUserDetail.dart';

import 'package:umq/tools/resourceProject/ResourceDimenAdmin.dart';
import 'package:umq/modules/place/data/model/MCity.dart';
import 'package:umq/modules/profile/data/model/MOrganization.dart';

import 'package:umq/tools/fastor/drawable/FastorDrawable.dart';
import 'package:umq/tools/resourceProject/DrawableProject.dart';
import 'package:umq/tools/responsive/fourm/ResponsiveFormMobile.dart';
import 'package:umq/toolsUI/textfield/mobileCountry/MobileCountryView.dart';
//import 'package:umq/toolsUI/toolbar/ToolbarSimpleFastor.dart';

class OrgDetailAdminPage extends StatefulWidget {

  MOrganization? mEdit  ;

  OrgDetailAdminPage( { MOrganization? edit }) {
    this.mEdit = edit;
  }

  @override
  OrgDetailAdminState createState() {
    return OrgDetailAdminState( mEdit: mEdit );
  }


}

class OrgDetailAdminState extends ResumableState<OrgDetailAdminPage > {

  //-------------------------------------------------------------------- variable
  String pageTitle = "Organization";
  MOrganization? mEdit  ;

  //name
  var nameEn_txt = "";
  var nameEn_valid = AutovalidateMode.disabled;
  var nameEn_controller = TextEditingController();


  //mobile
  MobileCountryViewState? mobileState;


  //constructor
  OrgDetailAdminState( { MOrganization? mEdit }) {
    this.mEdit = mEdit;
  }

  //------------------------------------------------------------------- life cycle


  @override
  void initState() {
    super.initState();

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

    if( mEdit != null ) {
      pageTitle = "Edit" + " " + pageTitle;
    }

    return PageTemplate.t( this,
        title: pageTitle,
        content: pageContent(),
        // assetBackgroundOpacity: 0.3,
        // assetBackground: DrawableProject.exampleAdmin(  "01"),
        toolbar: ToolbarSimpleFastor(  contextPage!,  pageTitle, iconColorBack: Colors.black ),
        toolbar_height: ToolbarSimpleFastor.frameHeight,
        onChangeProgressState: (value) => prg = value
    );
  }


  Widget pageContent() {
    return ResponsiveFourmMobile.wrapHeight(  contextPage!, getContent() );
  }

  Widget getContent() {
    return ColumnTemplate.t( children: [
      name_en(),

      save()
    ],
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.max,
    crossAxisAlignment: CrossAxisAlignment.start
    );
  }


}