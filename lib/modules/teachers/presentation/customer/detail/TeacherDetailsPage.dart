
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'package:umq/modules/teachers/data/model/MTeacher.dart';
import 'package:umq/modules/teachers/data/response/ResponseSingleTeacher.dart';
import 'package:umq/modules/teachers/presentation/customer/detail/logic/DownloadProviderController.dart';
import 'package:umq/modules/teachers/presentation/customer/detail/widgets/provider_details_header.dart';
import 'package:umq/toolsUI/app_colors.dart';
import 'package:umq/modules/teachers/presentation/customer/detail/widgets/products_gallery.dart';
import 'package:umq/modules/teachers/presentation/customer/detail/widgets/ProviderInfoView.dart';
import 'package:umq/modules/teachers/presentation/customer/detail/widgets/videos_gallery.dart';
import 'package:umq/toolsUI/scaffold/ScubaScaffoldSimple.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';


import 'widgets/images_gallery.dart';

class ProviderDetailsPage extends StatefulWidget {
  MProvider? provider;
  int? providerId;

  ProviderDetailsPage( {
  MProvider? provider,
  int? providerId
  } ) {
    if( provider != null ) this.provider = provider;
    if( providerId != null ) this.providerId = providerId;

    // if( provider != null ) {
    // providerId = provider.id;
    // }
  }

  @override
  ProviderDetailsState createState() => ProviderDetailsState();
}

class  ProviderDetailsState extends ResumableState<ProviderDetailsPage> {

  ResponseSingleProvider responseSingleProvider = new ResponseSingleProvider();
  bool loadingGallery = true;


  //--------------------------------------------------------------------- life cycle

  void initState() {
    super.initState();

  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    onResume();

  }

  @override
  void onResume() {
    // TODO: implement onResume
    super.onResume();
    prgState?.show();
   // Log.i( "providerDetail - onResume()" );
    startDownloadData();
  }


  Widget build(BuildContext context) {
    //Log.i( "providerDetail - build()" );
    String title = 'Profile';
    return  ScubaScaffoldSimple(title,  chooseTypeIdOrModel() );
  }

  //--------------------------------------------------------------------- PROGRESS

  Widget chooseTypeIdOrModel(){
    //check not found model
    if( widget.provider == null ) {
      return ProgressSpinkit.centerPage(context);
    }

    //show data
    return scrollVerticalByListViewStatic();
  }

  //------------------------------------------------------------------------ content

  Widget scrollVerticalByListViewStatic() {
    return ListView(
      children: [

        //margin
        SizedBox(
          height: 20,
        ),

        //item in list first
        getProviderDetailsHeader(),

        //item in list second
        ProviderInfoView(user: widget.provider!),

        //item in list third
        dataGalleryAllType()
      ],
    );
  }



  /**
   * wait after api
   */
  Widget dataGalleryAllType() {

    //check data downloaded
    if( responseSingleProvider == null ||
        //     loadingGallery ||
    responseSingleProvider.data == null ) {
      Log.i( "dataGalleryAllType() - show progress");
      return progressDownloadingGallery();
    }
    Log.i( "dataGalleryAllType() - show column content");

    //column
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      getProductsGallery( ),
      getImagesGallery( ),

      getVideosGallery( )
    ],);
  }

  ProgressCircleState? prgState;

  Widget progressDownloadingGallery(){
    var progress =  ProgressSpinkit.get( );
    return Container(
      child: progress,
      alignment: Alignment.bottomLeft,
      margin: EdgeInsets.only(top: 40),
    );
  }


}
