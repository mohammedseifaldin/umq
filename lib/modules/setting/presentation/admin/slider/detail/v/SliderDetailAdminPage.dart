
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'package:umq/modules/home/data/model/MSlider.dart';
import 'package:umq/modules/setting/presentation/admin/slider/detail/c/EditController.dart';
import 'package:umq/modules/setting/presentation/admin/slider/detail/v/views/ContentDetail.dart';
import 'package:umq/tools/responsive/fourm/ResponsiveFormMobile.dart';
//import 'package:umq/toolsUI/toolbar/ToolbarSimpleFastor.dart';

class SlideDetailAdminPage extends StatefulWidget {

  MSlider? mEdit  ;

  SlideDetailAdminPage( {super.key,  MSlider? edit }) {
    mEdit = edit;
  }

  @override
  SlideDetailAdminState createState() {
    return SlideDetailAdminState( mEdit: mEdit );
  }


}

class SlideDetailAdminState extends ResumableState<SlideDetailAdminPage > {

  //-------------------------------------------------------------------- variable

  String pageTitle = "Slide";
  MSlider? mEdit  ;

  //photo
  String photo_url_selected = "";
  late String photo_pathFile  ;
  ImageViewState? photo_state;
  var photo_progress_status = false ;

  //constructor
  SlideDetailAdminState( { MSlider? mEdit }) {
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


   ProgressCircleState? prg;

  @override
  Widget build(BuildContext context) {

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
        toolbar: ToolbarSimpleFastor(  context ,  pageTitle, iconColorBack: Colors.black ),
        toolbar_height: ToolbarSimpleFastor.frameHeight,
        onChangeProgressState: (value) => prg = value
    );
  }


  Widget pageContent() {
    return ResponsiveFourmMobile.wrapHeight(  context , getContent() );
  }

  Widget getContent() {
    return ColumnTemplate.t( children: [
      photo(),
      save()
    ],
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.max,
    crossAxisAlignment: CrossAxisAlignment.start
    );
  }


}