
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/teachers/data/response/ResponseSingleTeacher.dart';
import 'package:umq/modules/teachers/presentation/customer/detail/TeacherDetailsPage.dart';
import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/toolsUI/Widgets/button_primary_widget.dart';
import 'package:umq/toolsUI/app_colors.dart';
import 'package:umq/toolsUI/itemList/gallery/images/v/ItemImageGallery.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';
import 'package:umq/tools/network/ToolsAPI.dart';
import 'package:umq/toolsUI/circular_progress.dart';
import 'package:umq/toolsUI/no_data_widget.dart';



extension ImagesGallery  on ProviderDetailsState {

  Widget getImagesGallery( ) {


    return loadingGallery
        ? Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: circularProgress(),
          )
        : showImageContent();
  }


  Widget showImageContent(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30,
        ),
        Text(
          '* Images Gallery',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
        SizedBox(
          height: 15,
        ),


        //check no data found
        responseSingleProvider.data!.imageGallery!.length == 0
            ? noData()
            : imagesGalleryListWidget(),
      ],
    );
  }


  Widget imagesGalleryListWidget() {
    return Container(
      height: 150,
      child: ListView(scrollDirection: Axis.horizontal, children: [
        for (int i = 0; i < responseSingleProvider.data!.imageGallery!.length; i++)
          ItemImageGallery(  context, responseSingleProvider.data!.imageGallery![i])
      ]),
    );
  }



}
