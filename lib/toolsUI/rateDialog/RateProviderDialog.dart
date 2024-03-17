




import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'package:umq/tools/data/general/ResponseGeneral.dart';
import 'package:umq/modules/teachers/data/source/TeacherRateAPI.dart';
import 'package:umq/modules/teachers/data/model/MTeacher.dart';
import 'package:umq/modules/favorite/data/source/FavoriteTeacherApi.dart';
import 'package:umq/toolsUI/Widgets/button_primary_widget.dart';
import 'package:umq/toolsUI/rating_stars.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';
import 'package:umq/tools/resourceProject/DrawableProject.dart';

import 'package:umq/toolsUI/toast/ToastTools.dart';

class RateProviderDialog extends StatefulWidget {

  BuildContext contextPreviousPage;
  MProvider mProvider;

  // ValueChanged<bool> callBackRateComplete;

  RateProviderDialog(this.contextPreviousPage, this.mProvider ) ;

  @override
  RateProviderState createState() {
    return RateProviderState();
  }

}
class RateProviderState extends ResumableState<RateProviderDialog>  {


  double rating = 0.0;


  //-------------------------------------------------------------------- life cycle

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void onResume() {
    // TODO: implement onResume
    super.onResume();
    Log.i( "RateProviderDialog - onResume()" );

  }

  //-------------------------------------------------------------------- view

  BuildContext? contextCurrent;

  @override
  Widget build(BuildContext context) {
    this.contextCurrent = context;

    return Stack(children: [
      allPageTransparentColored(),

      //dismiss
      Positioned(child: bt_dismisAllPage(),  right: 20, top:  80),


      Positioned(child:  contentDialog(), left: 0, right: 0, top: 150,)
    ],);
  }

  Widget allPageTransparentColored(){
    return    EmptyView.colored(
          DeviceTools.getWidth(context),
          DeviceTools.getHeight(context),
          // Colors.transparent
          HexColor( ColorProject.blueTransparentDark )
      );
  }


  Widget bt_dismisAllPage(){
    return ImageView(width: 50+10, height: 50+10,
      assetAspectRatio: DrawableProject.admin( "cancel"),
      padding: EdgeInsets.all(10),
      onPressed: (){
        Navigator.pop( context );
      },);
  }


  //------------------------------------------------------------------- view

  Widget contentDialog() {
    return Container(
      height: 250,
      width: 200,
     // color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoarderHelper.rounded(
        colorLine: HexColor( ColorProject.blue_fish_front ),
          colorBackground: DSColor.ds_background_all_screen
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          titleRate(),

          SizedBox(
            height: 15,
          ),
          RatingStars(rating.toString(), 40.0, onChanged: (v) {

            setState(() {
              rating = v;
              Log.i( "Rating " + rating.toString() );
            });

          }),
          SizedBox(
            height: 15,
          ),

          buttonRate()

        ],
      ),
    );
  }

  Widget titleRate(){
    return  Text(
      'Rate In Stars',
      style: TextStyle(
          color: HexColor(ColorProject.blue_fish_front),
          fontSize: 18,
          decoration: TextDecoration.none,
          fontWeight: FontWeight.w800),
    );
  }


  Widget buttonRate(){
    return ButtonTemplate.t( "Rate", () {
      rateProviderApi();
    },
    levelDS: LevelDS.l2,
      width: 100,
      height: 50
    );
  }

  Widget rateText(){
    return  Text(
      'Rate',
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.none,
          fontSize: 16),
    );
  }

  //------------------------------------------------------------------- controller

  Future rateProviderApi( ) async {

    int providerId = widget.mProvider.id!;

    await ProviderRateAPI().getData(providerId,  rating, (status, msg, response ) {
      //Log.i("rateProvider() - response: " + msg.toString()   );
      ToolsToast.i(    contextCurrent!,  response.status??"Failed", wait_callBack: (){
        waitToShowMessageThenDismissPage();
      });

    }) ;


  }


  Future waitToShowMessageThenDismissPage() async {
    if( contextCurrent == null ) {
      Log.i("waitToShowMessageThenDismissPage() - contextCurrent is null  "   );
    } else {

      //finish current page
      Navigator.pop(contextCurrent!);

    }

    //
    // Navigator.pop(widget.contextPreviousPage);
    //callback
   // widget.callBackRateComplete(true);
  }




}