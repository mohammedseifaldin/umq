
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/teachers/data/response/ResponseSingleTeacher.dart';
import 'package:umq/modules/teachers/presentation/customer/detail/TeacherDetailsPage.dart';
import 'package:umq/toolsUI/app_colors.dart';
import 'package:umq/toolsUI/video/VideoPageFullScreen.dart';
import 'package:umq/toolsUI/itemList/gallery/video/v/ItemVideoGallery.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';
import 'package:umq/tools/network/ToolsAPI.dart';
import 'package:umq/toolsUI/no_data_widget.dart';


extension VideosGallery  on ProviderDetailsState {


  Widget getVideosGallery( ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 15,
        ),
        Text(
          '* Videos Gallery',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800),
        ),
        SizedBox(
          height: 15,
        ),
        responseSingleProvider.data!.videoGallery!.length == 0
            ? noData()
            : videosGalleryWidget(),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }


  Widget videosGalleryWidget() {
    return Container(
      height: 170,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (int i = 0; i < responseSingleProvider.data!.videoGallery!.length; i++)

            ItemVideoGallery(context, responseSingleProvider.data!.videoGallery![i])
        ],
      ),
    );
  }


}
