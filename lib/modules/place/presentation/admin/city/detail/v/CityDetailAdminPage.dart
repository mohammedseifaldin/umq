
import 'dart:typed_data';


import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'package:umq/modules/place/presentation/admin/city/detail/c/EditController.dart';
import 'package:umq/modules/place/presentation/admin/city/detail/v/views/ContentUserDetail.dart';

import 'package:umq/tools/resourceProject/ResourceDimenAdmin.dart';
import 'package:umq/modules/place/data/model/MCity.dart';

import 'package:umq/tools/fastor/drawable/FastorDrawable.dart';
import 'package:umq/tools/resourceProject/DrawableProject.dart';
import 'package:umq/tools/responsive/fourm/ResponsiveFormMobile.dart';
import 'package:umq/toolsUI/textfield/mobileCountry/MobileCountryView.dart';
//import 'package:umq/toolsUI/toolbar/ToolbarSimpleFastor.dart';

class CityDetailAdminPage extends StatefulWidget {

  MCity? mEdit  ;

  CityDetailAdminPage( { MCity? edit }) {
    this.mEdit = edit;
  }

  @override
  CityDetailAdminState createState() {
    return CityDetailAdminState( edit: mEdit );
  }


}

class CityDetailAdminState extends ResumableState<CityDetailAdminPage > {

  //-------------------------------------------------------------------- variable
  String pageTitle = "City";
  MCity? mEdit  ;

  //name
  var nameEn_txt = "";
  var nameEn_valid = AutovalidateMode.disabled;
  var nameEn_controller = TextEditingController();

  //email
  var nameAr_txt = "";
  var nameAr_valid = AutovalidateMode.disabled;
  var nameAr_controller = TextEditingController();

  //mobile
  MobileCountryViewState? mobileState;


  //constructor
  CityDetailAdminState( { MCity? edit }) {
    this.mEdit = edit;
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
        toolbar: ToolbarSimpleFastor(  contextPage!,  pageTitle , iconColorBack: Colors.black),
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
      name_ar(),
      save()
    ],
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.max,
    crossAxisAlignment: CrossAxisAlignment.start
    );
  }


}